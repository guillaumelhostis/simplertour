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
    # @venue = Venue.find(params[:concert][:venue_id])
    if @hotel.save
      redirect_to hotel_path(@hotel), notice: 'Concert was successfully created.'
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
