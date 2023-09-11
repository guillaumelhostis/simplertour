class AddColumnToTimetableEntry < ActiveRecord::Migration[7.0]
  def change
    add_column :timetable_entries, :hourminuteend, :time
  end
end
