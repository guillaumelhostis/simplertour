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
end
