class ConcertsController < ApplicationController




  def new
    @tour = Tour.find(params[:tour_id])
    @concert = @tour.concerts.build
  end

  def show
    @phoneprefix = ISO3166::Country.all.map { |country| "#{country.country_code}" }
    @phoneprefixsorted = @phoneprefix.uniq.sort_by(&:to_i).map {|c| "+#{c}"}


    @contact = Contact.new
    @guest = Guest.new
    @note = Note.new
    @checklist = Checklist.new
    @transport = Transport.new
    @transport_user = TransportUser.new

    @concert = Concert.find(params[:tour_id])
    @contacts = @concert.contacts
    @checklists = @concert.checklists
    @notes = @concert.notes
    @guests = @concert.guests
    @tour = Tour.find(params[:id])
    @crew = @tour.crew
    @timeentry = TimetableEntry.new
    @timetable_entries = TimetableEntry.where(concert_id: @concert).order(hourminute: :asc)
    status = @concert.calculate_status
    @status_text = Concert::STATUS_MAPPING[status]
    @concert.status = status
    @concert.save
    @crew_users = @crew.users
    @checklist_template = ChecklistTemplate.new
    @checklist_templates = ChecklistTemplate.where(tourman_id: current_tourman.id)
    @geocoders = []
    if @concert.venue_id.present?
      @venue = Venue.find(@concert.venue_id)
      @geocoders <<  @venue
    end
    if @concert.concert_hotels.present?
      hotel_ids_array = @concert.concert_hotels.pluck(:hotel_id)
      hotel_ids_array.each do |hotel|
        @geocoders <<  Hotel.find(hotel)
      end
    end
    @markers =  @geocoders.map do |location|
      {
        lat: location.latitude,
        lng: location.longitude,
        info_window_html: render_to_string(partial: "info_window", locals: {location: location})
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

    @concert = Concert.find(params[:tour_id])
    @concert.update(venue_id: nil)

    respond_to do |format|
      format.js
    end
  end

  def removetimetable


    # @concert = Concert.find(params[:tour_id].to_i)


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

  private

  def concert_params
    params.require(:concert).permit(:date, :location, :name, :venue_id, hotel_ids: [])
  end


end
