class Concert < ApplicationRecord

  STATUS_MAPPING = {
    0 => "Not Started",
    1 => "On Going",
    2 => "All Good",
    3 => "Past"
  }

  STATUS_CHOICES = STATUS_MAPPING.keys


  belongs_to :tour
  belongs_to :venue, optional: true
  belongs_to :hotel, optional: true
  has_many :concert_hotels, dependent: :destroy
  has_many :hotels, through: :concert_hotels
  has_many :transports, dependent: :destroy
  has_many :timetable_entries, dependent: :destroy
  has_many :contacts, dependent: :destroy
  has_many :checklists, dependent: :destroy
  has_many :guests, dependent: :destroy
  has_many :notes, dependent: :destroy
  validates :status, presence: true, inclusion: { in: STATUS_CHOICES }

  def status_name
    STATUS_MAPPING[status]
  end

  def calculate_status
    if date < Date.today
      return 3 # Past
    elsif checklists.empty?(&:status)
      return 0 # Not started
    elsif checklists.all?(&:status)
      return 2 # All Good
    elsif checklists.any?(&:status)
      return 1 # On Going
    elsif checklists.none?(&:status)
      return 0 # Not started
    end
  end
end
