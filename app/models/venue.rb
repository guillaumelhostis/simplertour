class Venue < ApplicationRecord
  has_many :concerts, dependent: :nullify
  before_destroy :nullify_concert_venues
  belongs_to :tourman
  has_many_attached :files

  def files=(attachables)
    attachables = Array(attachables).compact_blank

    if attachables.any?
      attachment_changes["files"] =
        ActiveStorage::Attached::Changes::CreateMany.new("files", self, files.blobs + attachables)
    end
  end

  private

  def nullify_concert_venues
    concerts.update_all(venue_id: nil)
  end
end
