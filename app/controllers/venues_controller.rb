class VenuesController < ApplicationController

  def index

    @tours = Tour.where(tourman_id: current_tourman.id)
    @concert_templates = ConcertTemplate.where(tourman_id: current_tourman.id)
    @venues = policy_scope(Venue).order('name ASC')

    if params[:query].present?
      @venues = Venue.search_by_name_and_city(params[:query])
    end
  end

  def new
    @concert = Concert.find(params[:format].to_i)
    @tour = Tour.find(@concert.tour_id)


    @tours = Tour.where(tourman_id: current_tourman.id)
    @concert_templates = ConcertTemplate.where(tourman_id: current_tourman.id)
    @venue = Venue.new
    authorize @venue
  end

  def show
    @tours = Tour.where(tourman_id: current_tourman.id)
    @concert_templates = ConcertTemplate.where(tourman_id: current_tourman.id)
    @venue = Venue.find(params[:id])
    authorize @venue
  end

  def create
    @concert = Concert.find(params[:venue][:concert].to_i)
    @tour = Tour.find(@concert.tour_id)
    @tours = Tour.where(tourman_id: current_tourman.id)
    @concert_templates = ConcertTemplate.where(tourman_id: current_tourman.id)
    @venue = Venue.new(venue_params)
    authorize @venue
    @venue.tourman_id = current_tourman.id
    if @venue.save
      params[:venue][:files].each do |file|
        @venue.files.attach(file)
      end
      if params[:venue][:concert].present?
        @concert.venue_id = @venue.id
        @concert.name = @venue.name
        @concert.save
        redirect_to tour_concert_path(@concert, @tour), notice: 'Hotel Created'
      else
        redirect_to new_venue_path, notice: 'Hotel Created'
      end
    else
      redirect_to new_venue_path, notice: 'Something went wrong'
    end
  end

  def edit
    @tours = Tour.where(tourman_id: current_tourman.id)
    @concert_templates = ConcertTemplate.where(tourman_id: current_tourman.id)
    @venue = Venue.find(params[:id])
    @existing_files = @venue.files
    authorize @venue
  end

  def update
    @tours = Tour.where(tourman_id: current_tourman.id)
    @concert_templates = ConcertTemplate.where(tourman_id: current_tourman.id)
    @venue = Venue.find(params[:id])
    if @venue.update(venue_params)
      authorize @venue
      redirect_to venues_path
    else
      redirect_to edit_venue_path(@venue), notice: 'Something went wrong'
    end

  end

  def destroy
    @tours = Tour.where(tourman_id: current_tourman.id)
    @concert_templates = ConcertTemplate.where(tourman_id: current_tourman.id)
    @venue = Venue.find(params[:id])
    authorize @venue
    @venue.destroy
    redirect_to venues_path, notice: 'Venue was successfully destroyed.'
  end

  private

  def venue_params
    params.require(:venue).permit(:name, :capacity, :postcode, :address, :city, :country, :tourman_id, files: [])
  end
end
