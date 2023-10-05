class ChecklistTemplate < ApplicationRecord
  has_many :checklist_template_descriptions, dependent: :destroy
end
