class CreateTransports < ActiveRecord::Migration[7.0]
  def change
    create_table :transports do |t|
      t.datetime :time_of_depart
      t.datetime :time_of_arrival
      t.string :place_of_depart
      t.string :place_of_arrival
      t.string :way_of_transport
      t.references :concert, foreign_key: true

      t.timestamps
    end
  end
end
