class AddColumnsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :birth_day, :date
    add_column :users, :address, :string
    add_column :users, :post_code, :integer
    add_column :users, :city, :string
    add_column :users, :country, :string
    add_column :users, :phone_number, :integer
    add_column :users, :diet, :string
  end
end
