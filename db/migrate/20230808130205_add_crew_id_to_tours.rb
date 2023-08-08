class AddCrewIdToTours < ActiveRecord::Migration[7.0]
  def change
    add_reference :tours, :crew, foreign_key: true
  end
end
