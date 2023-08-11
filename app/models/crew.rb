class Crew < ApplicationRecord
  has_many :crew_users
  has_many :users, through: :crew_users
  belongs_to :tour, optional: true
end
