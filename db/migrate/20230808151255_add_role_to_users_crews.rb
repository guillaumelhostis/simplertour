class AddRoleToUsersCrews < ActiveRecord::Migration[7.0]
  def change
    add_column :crews_users, :role, :string
  end
end
