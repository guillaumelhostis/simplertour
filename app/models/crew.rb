class Crew < ApplicationRecord
  has_many :crew_users
  has_many :users, through: :crew_users, dependent: :destroy
  has_one :tour, dependent: :destroy
end
