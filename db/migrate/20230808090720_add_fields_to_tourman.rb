class AddFieldsToTourman < ActiveRecord::Migration[7.0]
  def change
    add_column :tourmen, :first_name, :string
    add_column :tourmen, :last_name, :string
    add_column :tourmen, :birth_day, :date
    add_column :tourmen, :address, :string
    add_column :tourmen, :post_code, :integer
    add_column :tourmen, :city, :string
    add_column :tourmen, :country, :string
    add_column :tourmen, :phone_number, :integer
    add_column :tourmen, :diet, :string
  end
end
