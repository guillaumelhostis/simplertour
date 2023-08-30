class Hotel < ApplicationRecord
  has_many :concert_hotels
  has_many :concerts, through: :concert_hotels  #dependent: :nullify
  before_destroy :nullify_concert_hotels
  belongs_to :tourman

  private

  def nullify_concert_hotels
    concerts.update_all(hotel_id: nil)
  end
end
