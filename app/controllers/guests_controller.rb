class GuestsController < ApplicationController
  def create
    @tour = Tour.find(params[:tour_id])
    @concert = @tour.concerts.find(params[:concert_id])
    @guest = Guest.new(guest_params)
    @guest.concert_id = @concert.id
    authorize @guest
    if @guest.save
      redirect_to tour_concert_path(@concert, @tour), notice: 'New guest added'
    else
      redirect_to tour_concert_path(@concert, @tour)
    end
  end

  private

  def guest_params
    params.require(:guest).permit(:role, :first_name, :last_name, :country_code, :concert_id, :phone_number, :email)
  end
end
