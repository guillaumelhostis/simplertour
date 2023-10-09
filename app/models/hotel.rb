class Hotel < ApplicationRecord
  has_many :concert_hotels, dependent: :destroy
  has_many :concerts, through: :concert_hotels
  before_destroy :nullify_concert_hotels
  belongs_to :tourman
  geocoded_by :full_street_address
  after_validation :geocode, if: :will_save_change_to_address?

  def full_street_address
    [address, postcode, city, country].compact.join(', ')
  end

  private

  def nullify_concert_hotels
    concert_hotels.update_all(hotel_id: nil)
  end
end
