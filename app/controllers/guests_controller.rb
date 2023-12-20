class GuestsController < ApplicationController
  before_action :set_concert_and_tour, only: [:create]

  def create
    @guest = Guest.new(guest_params.merge(concert_id: @concert.id))
    authorize @guest
    if @guest.save
      redirect_to tour_concert_path(@concert, @tour), notice: 'New guest added'
    else
      redirect_to tour_concert_path(@concert, @tour), notice: 'Something went wrong'
    end
  end

  private

  def guest_params
    params.require(:guest).permit(:role, :first_name, :last_name, :country_code, :concert_id, :phone_number, :email)
  end

  def set_concert_and_tour
    @tour = Tour.find(params[:tour_id])
    @concert = Concert.find(params[:concert_id])
  end
end
