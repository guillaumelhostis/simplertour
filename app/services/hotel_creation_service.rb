class HotelCreationService

  def initialize(hotel_params, current_tourman, concert)
    @hotel_params = hotel_params
    @current_tourman = current_tourman
    @success = false
    @concert = concert
  end

  def call
    build_hotel
    save_hotel
    build_concert_hotel_associated if @success
  end

  def hotel
    @hotel
  end

  def success
    @success
  end

  private

  def build_hotel
    @hotel = Hotel.new(@hotel_params.merge(tourman_id: @current_tourman.id))
  end

  def build_concert_hotel_associated
    @concert_hotel = ConcertHotel.new(concert: @concert, hotel: @hotel)
    @concert_hotel.save
  end

  def save_hotel
    @success = @hotel.save
  end
end
