class AddCountryCodeToContact < ActiveRecord::Migration[7.0]
  def change
    add_column :contacts, :country_code, :string, default: nil
  end
end