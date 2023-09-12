class Contact < ApplicationRecord
  belongs_to :concert



  def full_number
      "#{country_code} #{phone_number}"
  end
end
