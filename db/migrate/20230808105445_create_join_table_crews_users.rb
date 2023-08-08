class CreateJoinTableCrewsUsers < ActiveRecord::Migration[7.0]
  def change
    create_join_table :crews, :users do |t|
      # t.index [:crew_id, :user_id]
      # t.index [:user_id, :crew_id]
    end
  end
end
