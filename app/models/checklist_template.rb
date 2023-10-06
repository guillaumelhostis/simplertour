class ChecklistTemplate < ApplicationRecord
  has_many :checklist_template_descriptions, dependent: :destroy
  # accepts_nested_attributes_for :checklist_template_descriptions
end
