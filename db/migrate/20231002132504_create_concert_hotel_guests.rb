class CreateConcertHotelGuests < ActiveRecord::Migration[7.0]
  def change
    create_table :concert_hotel_guests do |t|
      t.references :concert_hotels, null: false, foreign_key: true
      t.references :guests, null: false, foreign_key: true
      t.timestamps
    end
  end
end
