class CreateConcerts < ActiveRecord::Migration[7.0]
  def change
    create_table :concerts do |t|
      t.date :date
      t.string :location
      t.string :name
      t.references :tour, null: false, foreign_key: true

      t.timestamps
    end
  end
end
