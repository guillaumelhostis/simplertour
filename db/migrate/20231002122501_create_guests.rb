class CreateGuests < ActiveRecord::Migration[7.0]
  def change
    create_table :guests do |t|
      t.references :concert, null: false, foreign_key: true
      t.string :first_name, default: nil
      t.string :last_name, default: nil
      t.string :role, default: nil
      t.integer :phone_number, default: nil
      t.string :country_code, default: "+33"
      t.string :email, default: nil
      t.timestamps
    end
  end
end
