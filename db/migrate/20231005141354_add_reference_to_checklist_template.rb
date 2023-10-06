class AddReferenceToChecklistTemplate < ActiveRecord::Migration[7.0]
  def change

    add_reference :checklist_templates, :tourman, foreign_key: true
  end
end
