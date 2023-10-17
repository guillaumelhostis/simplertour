class CreateConcertTemplates < ActiveRecord::Migration[7.0]
  def change
    create_table :concert_templates do |t|

      t.timestamps
    end
  end
end
