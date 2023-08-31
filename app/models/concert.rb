class Concert < ApplicationRecord
  belongs_to :tour
  belongs_to :venue, optional: true
  belongs_to :hotel, optional: true
  has_many :concert_hotels, dependent: :destroy
  has_many :hotels, through: :concert_hotels
end
