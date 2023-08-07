class ToursController < ApplicationController
  before_action :set_tour, only: [:show, :edit, :update, :destroy]

  def index
    @tours = Tour.all
  end

  def show
  end

  def new
    @tour= Tour.new
  end

  def create
    @tour = Tour.new(tour_params)
    @tour.tourman_id = current_tourman.id
    @tour.save

    redirect_to tour_path(@tour)
  end

  def edit
  end

  def update
    @tour.update(tour_params)

    redirect_to tour_path(@tour)
  end

  def destroy
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
