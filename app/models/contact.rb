class Contact < ApplicationRecord
  belongs_to :concert
  validates :full_name, :role, presence: true

  def full_number
      "#{country_code} #{phone_number}"
  end
end
