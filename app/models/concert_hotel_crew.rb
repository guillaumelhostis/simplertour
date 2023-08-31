class ConcertHotelCrew < ApplicationRecord
  belongs_to :concert_hotel
  belongs_to :crew
end
