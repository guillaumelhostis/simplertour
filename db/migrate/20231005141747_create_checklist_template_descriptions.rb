class CreateChecklistTemplateDescriptions < ActiveRecord::Migration[7.0]
  def change
    create_table :checklist_template_descriptions do |t|
      t.string :description
      t.references :checklist_template, null: false, foreign_key: true

      t.timestamps
    end
  end
end
