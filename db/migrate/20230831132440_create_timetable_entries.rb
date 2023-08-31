class CreateTimetableEntries < ActiveRecord::Migration[7.0]
  def change
    create_table :timetable_entries do |t|
      t.references :concert, null: false, foreign_key: true
      t.integer :hour
      t.text :information

      t.timestamps
    end
  end
end
