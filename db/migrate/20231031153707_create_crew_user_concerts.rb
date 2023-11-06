class CreateCrewUserConcerts < ActiveRecord::Migration[7.0]
  def change
    create_table :crew_user_concerts do |t|
      t.references :concert, null: false, foreign_key: true
      t.references :crew_user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
