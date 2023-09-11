class ChangeDefaultForTimetableEntry < ActiveRecord::Migration[7.0]
  def change
    change_column :timetable_entries, :hourminuteend, :time, default: nil
  end
end
