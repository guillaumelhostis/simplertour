class CreateContacts < ActiveRecord::Migration[7.0]
  def change
    create_table :contacts do |t|
      t.references :concert, null: false, foreign_key: true
      t.string :full_name, default: nil
      t.string :role, default: nil
      t.string :email, default: nil
      t.integer :phone_number, default: nil

      t.timestamps
    end
  end
end
