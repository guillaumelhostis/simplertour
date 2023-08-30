class ConcertHotel < ApplicationRecord
  belongs_to :concert
  belongs_to :hotel
end
