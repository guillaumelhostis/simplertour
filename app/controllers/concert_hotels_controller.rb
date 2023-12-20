class ConcertHotelsController < ApplicationController
  before_action :set_concert_and_tour
  before_action :set_concert_hotel, only: [:add_crew, :add_guest, :remove_user, :remove_guest, :destroy]
  before_action :set_user, only: [:add_crew, :remove_crew]
  before_action :set_guest, only: [:add_guest, :remove_guest]

  def create
    @hotel = Hotel.find(params[:hotel_id])
    @concert_hotel = ConcertHotel.new(concert: @concert, hotel: @hotel)
    authorize @concert_hotel
    if @concert_hotel.save
      redirect_to tour_concerts_path(@concert.id), notice: 'Hotel was successfully added to the concert.'
    else
      redirect_to tour_concerts_path(@concert.id), alert: 'Failed to add hotel to the concert.'
    end
  end

  def add_crew
    @concert_hotel_user = ConcertHotelUser.new(concert_hotel: @concert_hotel, user: @user)
    if @concert_hotel_user.save
      redirect_to tour_concert_path(@concert, @tour), notice: "User added"
    else
      redirect_to tour_concert_path(@concert, @tour), notice: "Something went wrong"
    end
  end

  def add_guest
    @concert_hotel_guest = ConcertHotelGuest.new(concert_hotel: @concert_hotel, guest: @guest)
    if @concert_hotel_guest.save
      redirect_to tour_concert_path(@concert, @tour), notice: "Guest added"
    else
      redirect_to tour_concert_path(@concert, @tour), notice: "Something went wrong"
    end
  end

  def remove_user
    @concert_hotel_user = ConcertHotelUser.find_by(user_id: params[:user_id], concert_hotel_id: params[:id])
    if @concert_hotel_user.destroy
      redirect_to tour_concert_path(@concert, @tour), notice: "User removed"
    else
      redirect_to tour_concert_path(@concert, @tour), notice: "Something went wrong"
    end
  end

  def remove_guest
    @concert_hotel_guest = ConcertHotelGuest.find_by(guest_id: params[:guest_id], concert_hotel_id: params[:id])
    if @concert_hotel_guest.destroy
      redirect_to tour_concert_path(@concert, @tour), notice: "Guest removed"
    else
      redirect_to tour_concert_path(@concert, @tour), notice: "Something went wrong"
    end
  end

  def destroy
    if @concert_hotel.destroy
      redirect_to tour_concert_path(@tour, @concert), notice: 'Hotel was successfully removed.'
    else
      redirect_to tour_concert_path(@tour, @concert), notice: 'Something went wrong'
    end
  end

  private

  def set_concert_and_tour
    @tour = Tour.find(params[:tour_id])
    @concert = Concert.find(params[:concert_id])
  end

  def set_concert_hotel
    @concert_hotel = ConcertHotel.find(params[:id])
    authorize @concert_hotel
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_guest
    @guest = Guest.find(params[:guest_id])
  end
end
