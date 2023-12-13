class VenuesController < ApplicationController
  before_action :set_sidebar_instances
  before_action :set_venue, only: [:update, :destroy, :edit]
  before_action :set_concert_and_tour, only: [:new, :create]

  def index
    @venues = policy_scope(Venue).order('name ASC')
    if params[:query].present?
      @venues = Venue.search_by_name_and_city(params[:query])
    end
  end

  def new
    @venue = Venue.new
    authorize @venue
  end

  def create
    service = VenueCreationService.new(venue_params, current_tourman, @concert)
    service.call
    authorize service.venue
    if service.success
      redirect_to tour_concert_path(@concert, @tour), notice: 'Venue Created'
    else
      redirect_to new_venue_path(@concert), notice: 'Something went wrong'
    end
  end

  def edit
    @existing_files = @venue.files
  end

  def update
    if @venue.update(venue_params)
      redirect_to venues_path
    else
      redirect_to edit_venue_path(@venue), notice: 'Something went wrong'
    end
  end

  def destroy
    @venue.destroy
    redirect_to venues_path, notice: 'Venue was successfully destroyed.'
  end

  private

  def venue_params
    params.require(:venue).permit(:name, :capacity, :postcode, :address, :city, :country, :tourman_id, files: [])
  end

  def set_sidebar_instances
    @tours = Tour.where(tourman_id: current_tourman.id)
    @concert_templates = ConcertTemplate.where(tourman_id: current_tourman.id)
  end

  def set_venue
    @venue = Venue.find(params[:id])
    authorize @venue
  end

  def set_concert_and_tour
    if !params[:venue].nil?
      @concert = Concert.find(params[:venue][:concert].to_i)
    elsif params[:format]
      @concert = Concert.find(params[:format].to_i)
    end
    @tour = Tour.find(@concert.tour_id)
  end
end
