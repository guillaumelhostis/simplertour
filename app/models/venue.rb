class Venue < ApplicationRecord
  has_many :concerts, dependent: :nullify
  before_destroy :nullify_concert_venues
  belongs_to :tourman

  private

  def nullify_concert_venues
    concerts.update_all(venue_id: nil)
  end
end
