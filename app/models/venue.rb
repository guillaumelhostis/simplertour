class Venue < ApplicationRecord
  has_many :concerts, dependent: :nullify
  before_destroy :nullify_concert_venues
  belongs_to :tourman
  has_many_attached :files
  geocoded_by :full_street_address
  after_validation :geocode, if: :will_save_change_to_address?

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
