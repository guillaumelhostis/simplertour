class ToursController < ApplicationController
  before_action :set_tour, only: [:show, :destroy]
  before_action :set_tour_and_concert_templates , only: [:index, :show, :new]

  def index
    @tour = Tour.new
    @tours = policy_scope(Tour)
  end

  def show
      service = TourShowService.new(@tour)
      service.call
      @crew = service.crew
      @crew_users = service.crew_users
      @concerts = service.concerts
      @concert_dates = service.concert_dates
      @concert_index = service.concert_index
      @concert_status = service.concert_status
      @concert = Concert.new
      @today_concerts = service.today_concerts
      @upcoming_concerts = service.upcoming_concerts
  end

  def new
    @tour= Tour.new
    authorize @tour
  end

  def create
    service = TourCreationService.new(tour_params, current_tourman)
    service.call
    authorize service.tour
    if service.success
      redirect_to tour_path(service.tour), notice: "#{service.tour.title} created"
    else
      redirect_to tours_path, notice: "Something went wrong"
    end
  end

  def destroy
    if @tour.destroy
      redirect_to tours_path, notice: "Tour destroyed"
    else
      redirect_to tour_path(@tour), notice: "Something went wrong"
    end
  end

  private

  def tour_params
    params.require(:tour).permit(:title, :artist, :genre, :starting, :ending, :picture, concerts_attributes: [:date, :location, :name, :venue_id, hotel_ids: []])
  end

  def set_tour
    @tour = Tour.find_by(id: params[:id])
    if @tour.present?
      authorize @tour
    else
      redirect_to tours_path, notice: "This Tour doesn't exist"
    end
  end

  def set_tour_and_concert_templates
    @tours = Tour.where(tourman_id: current_tourman.id)
    @concert_templates = ConcertTemplate.where(tourman_id: current_tourman.id)
  end
end
