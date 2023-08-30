class CreateConcertHotels < ActiveRecord::Migration[7.0]
  def change
    create_table :concert_hotels do |t|
      t.references :concert, null: false, foreign_key: true
      t.references :hotel, null: false, foreign_key: true

      t.timestamps
    end
  end
end
