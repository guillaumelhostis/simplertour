class AddVenueRefToConcerts < ActiveRecord::Migration[7.0]
  def change
    add_reference :concerts, :venue, foreign_key: true, null: false
  end
end
