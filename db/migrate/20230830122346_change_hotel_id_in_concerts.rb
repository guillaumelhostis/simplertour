class ChangeHotelIdInConcerts < ActiveRecord::Migration[7.0]
  def change
    change_column :concerts, :hotel_id, :integer, null: true, foreign_key: true
  end
end
