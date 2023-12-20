class GuestListsController < ApplicationController
  before_action :set_concert_and_tour, only: [:create, :destroy]

  def create
    @guest_list = GuestList.new(guest_list_params.merge(concert_id: @concert.id))
    authorize  @guest_list
    if @guest_list.save
      redirect_to tour_concert_path(@concert, @tour), notice: "Guest added."
    else
      redirect_to tour_concert_path(@concert, @tour), notice: "Something went wrong"
    end
  end

  def destroy
    @guest_list = GuestList.find(params[:id])
    @guest_list.destroy
    authorize  @guest_list
    redirect_to tour_concert_path(@concert, @tour), notice: "Guest deleted"
  end

  private

  def guest_list_params
    params.require(:guest_list).permit(:name)
  end

  def set_concert_and_tour
    @tour = Tour.find(params[:tour_id])
    @concert = Concert.find(params[:concert_id])
  end
end
