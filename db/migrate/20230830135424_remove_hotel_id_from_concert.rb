class RemoveHotelIdFromConcert < ActiveRecord::Migration[7.0]
  def change
    remove_column :concerts, :hotel_id
  end
end
