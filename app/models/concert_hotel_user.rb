class ConcertHotelUser < ApplicationRecord
  belongs_to :concert_hotel
  belongs_to :user
end
