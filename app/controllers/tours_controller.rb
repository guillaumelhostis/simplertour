class ToursController < ApplicationController
  before_action :set_tour, only: [:show, :edit, :update, :destroy]

  def index
    @tours = policy_scope(Tour)
    @even_index_tours = []
    @odd_index_tours = []
    @tours.each_with_index do |tour, index|
      if index.even?
        @even_index_tours << tour
      else
        @odd_index_tours << tour
      end
    end

  end

  def show
    authorize @tour
    @crew = Crew.find(@tour.crew_id)
    @crew_users = @crew.users
    @concerts = @tour.concerts
    @concert_dates = []
    @concert_index = []
    @concert_status = []

    @concerts.each do |concert|
      @concert_dates << concert.date.strftime("%B %e, %Y").gsub(/[[:space:]]/, '')
    end

    @concerts.each do |concert|
      @concert_index << concert.id
    end

    @concerts.each do |concert|
      status = concert.calculate_status
      concert.status = status
      concert.save

      @concert_status << concert.status
    end

    @concert = Concert.new
  end

  def new
    @tour= Tour.new
    authorize @tour
  end

  def create

    @tour = Tour.new(tour_params)
    @tour.tourman_id = current_tourman.id
    authorize @tour
    @tour.save
    @newcrew = Crew.new(name: "Team #{@tour.title}")
    @newcrew.save
    @tour.crew_id = @newcrew.id
    @tour.save

    redirect_to crew_path(@newcrew)
  end

  def edit
    authorize @tour
  end

  def update
    authorize @tour
    @tour.update(tour_params)

    redirect_to tour_path(@tour)
  end

  def destroy
    authorize @tour

    @tour.destroy

    # No need for app/views/restaurants/destroy.html.erb
    redirect_to tours_path, status: :see_other
  end

  private

  def tour_params
    params.require(:tour).permit(:title, :artist, :genre, :starting, :ending, :picture, concerts_attributes: [:date, :location, :name, :venue_id, hotel_ids: []])
  end

  def set_tour
    @tour = Tour.find(params[:id])
  end
end
