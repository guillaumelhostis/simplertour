class ConcertHotelGuest < ApplicationRecord
  belongs_to :concert_hotel
  belongs_to :guest
end
