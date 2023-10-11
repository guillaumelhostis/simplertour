class HotelsController < ApplicationController

  def new
    @hotel = Hotel.new
    authorize @hotel
  end

  def show
    @hotel = Hotel.find(params[:id])
    authorize @hotel
  end

  def create
    @hotel = Hotel.new(hotel_params)
    authorize @hotel
    @hotel.tourman_id = current_tourman.id
    if @hotel.save
      if params[:concert].present? && params[:tour].present?
        @concert = Concert.find(params[:concert])
        @tour = Tour.find(params[:tour])
        @concert_hotel = ConcertHotel.new(concert: @concert, hotel: @hotel)
        @concert_hotel.save
        redirect_to tour_concert_path(@concert, @tour), notice: 'Hotel was successfully created.'
      else
        redirect_to hotel_path(@hotel), notice: 'Concert was successfully created.'
      end
    else
      redirect_to new_hotel_path, notice: 'Could not add a new show something went wrong'
    end
  end

  def destroy
    @hotel = Hotel.find(params[:id])
    authorize @hotel
    @hotel.destroy
    authorize @hotel
    redirect_to tours_path, notice: 'Venue was successfully destroyed.'
  end

  private

  def hotel_params
    params.require(:hotel).permit(:name, :standing, :postcode, :address, :city, :country, :tourman_id)
  end


end
