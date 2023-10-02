class ChangeColumnConcertHotelGuests < ActiveRecord::Migration[7.0]
  def change

    remove_column :concert_hotel_guests, :guests_id
    remove_column :concert_hotel_guests, :concert_hotels_id
  end
end
