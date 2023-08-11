class DropCrewsUsers < ActiveRecord::Migration[7.0]
  def change
    drop_table :crews_users
  end
end
