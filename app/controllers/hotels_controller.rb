class HotelsController < ApplicationController
  before_action :set_tours_and_concerts_templates, only: [:index, :edit, :update, :destroy]
  before_action :set_hotel, only: [:show, :edit, :update, :destroy]

  def index
    @hotels = policy_scope(Hotel)
  end

  def new
    @hotel = Hotel.new
    authorize @hotel
  end

  def show
  end

  def edit
  end

  def update
    if @hotel.update(hotel_params)
      redirect_to hotels_path, notice: 'Hotel infos updated'
    else
      redirect_to edit_hotel_path(@hotel), notice: 'Something went wrong'
    end
  end

  def create
    @concert = Concert.find(params[:concert])
    @tour = Tour.find(params[:tour])
    service = HotelCreationService.new(hotel_params, current_tourman, @concert)
    service.call
    authorize service.hotel
    if service.success
      redirect_to tour_concert_path(@concert, @tour), notice: 'Hotel was successfully created.'
    else
      redirect_to tour_concert_path(@concert, @tour), notice: 'Something went wrong'
    end
  end

  def destroy
    if @hotel.destroy
      redirect_to tours_path, notice: 'Hotel was successfully destroyed.'
    else
      redirect_to hotels_path, notice: 'Something went wrong'
    end
  end

  private

  def hotel_params
    params.require(:hotel).permit(:name, :standing, :postcode, :address, :city, :country, :tourman_id)
  end

  def set_tours_and_concerts_templates
    @tours = Tour.where(tourman_id: current_tourman.id)
    @concert_templates = ConcertTemplate.where(tourman_id: current_tourman.id)
  end

  def set_hotel
    @hotel = Hotel.find_by(id: params[:id])
    if @hotel.present?
      authorize @hotel
    else
      redirect_to hotels_path, notice: "This hotel doesn't exist"
    end
  end
end
