class Crew < ApplicationRecord
  has_and_belongs_to_many :users
  belongs_to :tour, optional: true
end
