class AddReferencesToConcertHotelGuests < ActiveRecord::Migration[7.0]
  def change
    add_reference :concert_hotel_guests, :guest, foreign_key: true
    add_reference :concert_hotel_guests, :concert_hotel, foreign_key: true
  end
end
