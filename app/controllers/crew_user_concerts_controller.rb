class CrewUserConcertsController < ApplicationController

  def create
    @tour = Tour.find(params[:tour_id].to_i)
    @concert = Concert.find(params[:concert_id].to_i)
    @crew = Crew.find(@tour.crew_id)
    @crew_user = CrewUser.find_by(user_id: params[:user_id], crew_id: @crew.id )
    @crew_user_concert = CrewUserConcert.new(crew_user_id: @crew_user.id, concert_id: @concert.id)
    authorize @crew_user_concert
    if @crew_user_concert.save
      redirect_to tour_concert_path(@concert, @tour), notice: 'Team updated'
    else
      redirect_to tour_concert_path(@concert, @tour), notice: 'Something went wrong'
    end
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
