class CreateGuestList < ActiveRecord::Migration[7.0]
  def change
    create_table :guest_lists do |t|
      t.string :name
      t.references :concert, foreign_key: true
      t.timestamps
    end
  end
end
