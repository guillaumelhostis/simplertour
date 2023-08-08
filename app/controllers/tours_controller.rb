class ToursController < ApplicationController
  before_action :set_tour, only: [:show, :edit, :update, :destroy]

  def index
    @tours = policy_scope(Tour)
  end

  def show
    authorize @tour
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
    params.require(:tour).permit(:title, :artist, :genre, :starting, :ending)
  end

  def set_tour
    @tour = Tour.find(params[:id])
  end
end
