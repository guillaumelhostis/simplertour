class CreateConcertHotelCrews < ActiveRecord::Migration[7.0]
  def change
    create_table :concert_hotel_crews do |t|
      t.references :concert_hotel, null: false, foreign_key: true
      t.references :crew, null: false, foreign_key: true

      t.timestamps
    end
  end
end
