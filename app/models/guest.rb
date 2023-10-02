class Guest < ApplicationRecord
  belongs_to :concert

  def full_name
    "#{first_name} #{last_name}"
  end
end
