class AddDataToConcertTemplates < ActiveRecord::Migration[7.0]
  def change
    add_column :concert_templates, :data, :text
  end
end
