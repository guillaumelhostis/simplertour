class ConcertsController < ApplicationController

  def new
    @tour = Tour.find(params[:tour_id])
    @concert = @tour.concerts.build
  end

  def show
    @concert_templates = ConcertTemplate.where(tourman_id: current_tourman.id)
    @tours = Tour.where(tourman_id: current_tourman.id)
    @phoneprefix = ISO3166::Country.all.map { |country| "#{country.country_code}" }
    @phoneprefixsorted = @phoneprefix.uniq.sort_by(&:to_i).map {|c| "+#{c}"}
    @contact = Contact.new
    @guest = Guest.new
    @note = Note.new
    @checklist = Checklist.new
    @concert_template = ConcertTemplate.new
    @transport = Transport.new
    @transport_user = TransportUser.new
    @hotel = Hotel.new
    @concert = Concert.find(params[:tour_id])
    @contacts = @concert.contacts
    @checklists = @concert.checklists
    @notes = @concert.notes
    @guests = @concert.guests
    @tour = Tour.find(params[:id])
    @crew = @tour.crew
    @guest_lists =  @concert.guest_lists
    @guest_list =  GuestList.new
    @timeentry = TimetableEntry.new
    @timetable_entries = TimetableEntry.where(concert_id: @concert).order(hourminute: :asc)
    status = @concert.calculate_status
    @status_text = Concert::STATUS_MAPPING[status]
    @concert.status = status
    @concert.save
    @crew_users = @crew.crew_users
    @crew_user_concert = CrewUserConcert.new
    @users_on_this_concert = []

    @crew_user_concerts = @concert.crew_user_concerts
    @crew_user_concerts.each do |crew_user_concert|
      @users_on_this_concert << crew_user_concert.crew_user.user
    end

    @checklist_template = ChecklistTemplate.new
    @checklist_templates = ChecklistTemplate.where(tourman_id: current_tourman.id)
    @hotel_geocoders = []
    @venue_geocoders = []
    if @concert.venue_id.present?
      @venue = Venue.find(@concert.venue_id)
      @venue_geocoders <<  @venue
    end
    if @concert.concert_hotels.present?
      hotel_ids_array = @concert.concert_hotels.pluck(:hotel_id)
      hotel_ids_array.each do |hotel|
        @hotel_geocoders <<  Hotel.find(hotel)
      end
    end
    @venue_markers =  @venue_geocoders.map do |location|
      {
        lat: location.latitude,
        lng: location.longitude,
        info_window_html: render_to_string(partial: "info_window", locals: {location: location}),
        marker_html: render_to_string(partial: "venue_marker")
      }
    end
    @hotel_markers =  @hotel_geocoders.map do |location|
      {
        lat: location.latitude,
        lng: location.longitude,
        info_window_html: render_to_string(partial: "info_window", locals: {location: location}),
        marker_html: render_to_string(partial: "hotel_marker")
      }
    end
    authorize @concert
  end

  def create
    @tour = Tour.find(params[:tour_id])
    @concert = @tour.concerts.build(concert_params)
    authorize @concert


    # @venue = Venue.find(params[:concert][:venue_id])
    @concert.venue = nil
    # @concert.hotel = nil
    if @concert.save
      redirect_to tour_path(@tour), notice: 'Concert was successfully created.'
    else
      redirect_to tour_path(@tour), notice: 'Could not add a new show something went wrong'
    end
  end

  def edit
    @tour = Tour.find(params[:tour_id])
    @concert = @tour.concerts.find(params[:id])
    authorize @concert
  end

  def update
    @tour = Tour.find(params[:tour_id])
    @concert = @tour.concerts.find(params[:id])


    authorize @concert

    if @concert.update(concert_params)

      redirect_to tour_concert_path(@concert), notice: 'Concert was successfully updated.'
    else
      render :show
    end
  end

  def destroy

    @tour = Tour.find(params[:tour_id])
    @concert = @tour.concerts.find(params[:id])
    authorize @concert
    @concert.destroy
    redirect_to tour_path(@tour), notice: 'Concert was successfully deleted.'
  end

  def remove_venue
    @tour = Tour.find(params[:id].to_i)
    @concert = Concert.find(params[:tour_id])
    @concert.update(venue_id: nil)
    authorize @concert
    # respond_to do |format|
    #   format.js
    # end
    redirect_to tour_concert_path(@tour, @concert), notice: 'Venue Removed'
  end

  def removetimetable
    @timetable_entry = TimetableEntry.find(params[:timetable_entry_id].to_i)
    @concert = Concert.find(params[:concert_id].to_i)
    @tour = Tour.find(params[:tour_id].to_i)
    authorize @concert

    @timetable_entry.destroy
    redirect_to tour_concert_path(@tour, @concert), notice: 'Timetable updated'
  end

  def remove_contact
    @contact = Contact.find(params[:contact_id].to_i)
    @concert = Concert.find(params[:concert_id].to_i)
    @tour = Tour.find(params[:tour_id].to_i)

    authorize @concert

    @contact.destroy
    redirect_to tour_concert_path(@tour, @concert), notice: 'Contact Delete'
  end

  def roadbook_email
    @concert = Concert.find(params[:tour_id].to_i)
    authorize @concert
    @tour = Tour.find(params[:concert_id].to_i)
    @crew = @tour.crew
    @crew_users = @crew.users

    @crew_users.each do |user|
      RoadbookMailer.roadbook_email(user).deliver_now
    end
    redirect_to tour_concert_path(@concert, @tour), notice: 'Mails sent'
  end


  private

  def concert_params
    params.require(:concert).permit(:date, :location, :name, :venue_id, hotel_ids: [])
  end


end
