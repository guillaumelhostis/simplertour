class AddNameToConcertTemplates < ActiveRecord::Migration[7.0]
  def change
    add_column :concert_templates, :name, :string
  end
end
