class ChangeHourminuteInTimetableEntries < ActiveRecord::Migration[7.0]
  def change
    change_column :timetable_entries, :hourminute, :time, default: nil
  end
end
