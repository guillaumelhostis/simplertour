class RemoveHourToTimetableEntry < ActiveRecord::Migration[7.0]
  def change
    remove_column :timetable_entries, :hour
  end
end
