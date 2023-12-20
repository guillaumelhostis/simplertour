class CrewUserConcertsController < ApplicationController
  before_action :set_concert_and_tour, only: [:create, :destroy]

  def create
    service = CrewUserConcertCreationService.new(params[:user_id], @tour, @concert)
    service.call
    authorize service.crew_user_concert
    if service.success
      redirect_to tour_concert_path(@concert, @tour), notice: 'Team updated'
    else
      redirect_to tour_concert_path(@concert, @tour), notice: 'Something went wrong'
    end
  end

  def destroy
    @crew_user_concert = CrewUserConcert.find(params[:id])
    authorize @crew_user_concert
    if @crew_user_concert.destroy
      redirect_to tour_concert_path(@concert, @tour), notice: 'User removed.'
    else
      redirect_to tour_concert_path(@concert, @tour), notice: 'Something went wrong'
    end
  end

  private

  def set_concert_and_tour
    @tour = Tour.find(params[:tour_id].to_i)
    @concert = Concert.find(params[:concert_id].to_i)
  end
end
