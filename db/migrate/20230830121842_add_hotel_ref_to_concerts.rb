class AddHotelRefToConcerts < ActiveRecord::Migration[7.0]
  def change
    add_reference :concerts, :hotel, foreign_key: true
  end
end
