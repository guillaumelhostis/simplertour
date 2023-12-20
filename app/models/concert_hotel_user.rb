class ConcertHotelUser < ApplicationRecord
  belongs_to :concert_hotel
  belongs_to :user
  validates_uniqueness_of :concert_hotel_id, scope: :user_id
end
