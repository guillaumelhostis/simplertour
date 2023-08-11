class ChangeVenueIdInConcerts < ActiveRecord::Migration[7.0]

  def change
    change_column :concerts, :venue_id, :integer, null: true, foreign_key: true
  end

end
