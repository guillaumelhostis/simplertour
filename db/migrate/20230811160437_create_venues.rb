class CreateVenues < ActiveRecord::Migration[7.0]
  def change
    create_table :venues do |t|
      t.string :name
      t.string :address
      t.integer :postcode
      t.string :city
      t.string :country
      t.integer :capacity

      t.timestamps
    end
  end
end
