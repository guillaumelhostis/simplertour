class ConcertHotel < ApplicationRecord
  belongs_to :concert
  belongs_to :hotel

  has_many :concert_hotel_crews
  has_many :crews, through: :concert_hotel_crews
  has_many :concert_hotel_users
  has_many :users, through: :concert_hotel_users
end
