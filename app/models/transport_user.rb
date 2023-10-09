class TransportUser < ApplicationRecord
  belongs_to :user
  belongs_to :transport
  validates :user_id, uniqueness: { scope: :transport_id }
end
