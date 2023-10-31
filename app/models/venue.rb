class Venue < ApplicationRecord
  include PgSearch::Model
  has_many :concerts, dependent: :nullify
  before_destroy :nullify_concert_venues
  belongs_to :tourman
  has_many_attached :files
  geocoded_by :full_street_address
  after_validation :geocode, if: :will_save_change_to_address?
  pg_search_scope :search_by_name_and_city,
    against: [ :name, :city ],
    using: {
      tsearch: { prefix: true } # <-- now `superman batm` will return something!
    }

  def files=(attachables)
    attachables = Array(attachables).compact_blank

    if attachables.any?
      attachment_changes["files"] =
        ActiveStorage::Attached::Changes::CreateMany.new("files", self, files.blobs + attachables)
    end
  end

  def full_street_address

    [address, postcode, city, country].compact.join(', ')
  end

  private

  def nullify_concert_venues
    concerts.update_all(venue_id: nil)
  end
end
