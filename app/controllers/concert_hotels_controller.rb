class ConcertHotelsController < ApplicationController

  def create
    @tour = Tour.find(params[:tour_id])
    @concert = @tour.concerts.find(params[:concert_id])
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
    @tour = Tour.find(params[:tour_id])
    @concert = @tour.concerts.find(params[:concert_id])
    @concert_hotel = @concert.concert_hotels.find(params[:id])
    @user = User.find(params[:user_id])
    @concert_hotel_user = ConcertHotelUser.new(concert_hotel: @concert_hotel, user: @user)
    @concert_hotel_user.save


    respond_to do |format|
      format.js   # Render JavaScript response
    end
  end

  def remove_user
    @tour = Tour.find(params[:tour_id])
    @concert = @tour.concerts.find(params[:concert_id])
    @concert_hotel = @concert.concert_hotels.find(params[:id])
    @user = User.find(params[:user_id])

    @concert_hotel_user = @concert_hotel.concert_hotel_users.find_by(user: @user)
    @concert_hotel_user.destroy

    respond_to do |format|
      format.js   # Render JavaScript response
    end
  end

end
