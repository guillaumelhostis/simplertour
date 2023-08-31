class AddTimeToTimetableEntry < ActiveRecord::Migration[7.0]
  def change
    add_column :timetable_entries, :hourminute, :time
  end
end
