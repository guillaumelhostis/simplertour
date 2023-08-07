class RemoveTypeFromTour < ActiveRecord::Migration[7.0]
  def change
    remove_column :tours, :type, :string
  end
end
