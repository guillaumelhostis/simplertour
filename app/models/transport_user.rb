class TransportUser < ApplicationRecord
  belongs_to :user
  belongs_to :transport
  validates :user_id, uniqueness: { scope: :transport_id }
  has_many_attached :files

  def files=(attachables)
    attachables = Array(attachables).compact_blank
    if attachables.any?
      attachment_changes["files"] =
        ActiveStorage::Attached::Changes::CreateMany.new("files", self, files.blobs + attachables)
    end
  end
end
