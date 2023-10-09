class AddGeocodeColumnsToTransports < ActiveRecord::Migration[7.0]
  def change
    add_column :transports, :arrival_latitude, :float
    add_column :transports, :arrival_longitude, :float
    add_column :transports, :depart_latitude, :float
    add_column :transports, :depart_longitude, :float
  end
end
