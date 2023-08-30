class CreateHotels < ActiveRecord::Migration[7.0]
  def change
    create_table :hotels do |t|
      t.string :name
      t.string :address
      t.integer :postcode
      t.string :city
      t.string :country
      t.integer :standing
      t.integer :tourman_id
      t.timestamps
    end
  end

end
