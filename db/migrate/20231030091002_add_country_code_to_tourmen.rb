class AddCountryCodeToTourmen < ActiveRecord::Migration[7.0]
  def change
    add_column :tourmen, :country_code, :string
  end
end
