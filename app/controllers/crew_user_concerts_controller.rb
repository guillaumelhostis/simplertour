class CrewUserConcertsController < ApplicationController

  def create
    raise
  end

  def destroy
    @tour = Tour.find(params[:tour_id].to_i)
    @concert = Concert.find(params[:concert_id].to_i)
    @crew_user_concert = CrewUserConcert.find(params[:id])
    authorize @crew_user_concert
    @crew_user_concert.destroy
    redirect_to tour_concert_path(@concert, @tour), notice: 'Crew User removed.'
  end
end
