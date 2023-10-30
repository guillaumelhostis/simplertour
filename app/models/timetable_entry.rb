class TimetableEntry < ApplicationRecord
  belongs_to :concert
  validates :hourminute, presence: true
  validates :information, presence: true
end
