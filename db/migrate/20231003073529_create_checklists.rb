class CreateChecklists < ActiveRecord::Migration[7.0]
  def change
    create_table :checklists do |t|
      t.string :description
      t.boolean :status, default: false
      t.references :concert, null: false, foreign_key: true

      t.timestamps
    end
  end
end
