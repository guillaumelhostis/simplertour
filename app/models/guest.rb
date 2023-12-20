class Guest < ApplicationRecord
  belongs_to :concert
  validates :first_name, :last_name, :role, :email, presence: true

  def full_name
    "#{first_name} #{last_name}"
  end
end
