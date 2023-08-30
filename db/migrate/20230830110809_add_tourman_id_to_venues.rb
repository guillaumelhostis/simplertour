class AddTourmanIdToVenues < ActiveRecord::Migration[7.0]
  def change
    add_column :venues, :tourman_id, :integer
  end
end
