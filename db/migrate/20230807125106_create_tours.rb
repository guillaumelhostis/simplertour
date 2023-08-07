class CreateTours < ActiveRecord::Migration[7.0]
  def change
    create_table :tours do |t|
      t.string :title
      t.string :artist
      t.string :type
      t.date :starting
      t.date :ending
      t.references :tourman, null: false, foreign_key: true

      t.timestamps
    end
  end
end
