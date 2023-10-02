class AddFieldToNotes < ActiveRecord::Migration[7.0]
  def change
    add_column :notes, :description, :string, default: nil
  end
end
