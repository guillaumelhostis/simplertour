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
    authorize @concert_hotel
    redirect_to tour_concert_path(@concert, @tour)
  end

  def add_guest
    @tour = Tour.find(params[:tour_id])
    @concert = @tour.concerts.find(params[:concert_id])
    @concert_hotel = @concert.concert_hotels.find(params[:id])
    @guest = Guest.find(params[:guest_id])
    @concert_hotel_guest = ConcertHotelGuest.new(concert_hotel: @concert_hotel, guest: @guest)
    @concert_hotel_guest.save
    authorize @concert_hotel
    redirect_to tour_concert_path(@concert, @tour)
  end

  def remove_user
    @tour = Tour.find(params[:tour_id])
    @concert = @tour.concerts.find(params[:concert_id])
    @concert_hotel = @concert.concert_hotels.find(params[:id])
    @user = User.find(params[:user_id])
    @concert_hotel_user = @concert_hotel.concert_hotel_users.find_by(user: @user)
    authorize @concert_hotel
    @concert_hotel_user.destroy
    redirect_to tour_concert_path(@concert, @tour)
  end

  def remove_guest
    @tour = Tour.find(params[:tour_id])
    @concert = @tour.concerts.find(params[:concert_id])
    @concert_hotel = @concert.concert_hotels.find(params[:id])
    @guest = Guest.find(params[:guest_id])
    @concert_hotel_guest = @concert_hotel.concert_hotel_guests.find_by(guest: @guest)
    authorize @concert_hotel
    @concert_hotel_guest.destroy
    redirect_to tour_concert_path(@concert, @tour)
  end

  def destroy
    @concert_hotel = ConcertHotel.find(params[:id])
    authorize @concert_hotel
    @concert_hotel.destroy
    @tour = Tour.find(params[:tour_id])
    @concert = @tour.concerts.find(params[:concert_id])
    respond_to do |format|
      format.html { redirect_to tour_concert_path(@tour, @concert), notice: 'Concert hotel was successfully removed.' }
      format.json { head :no_content }
    end
  end
end
