class Concert < ApplicationRecord
  belongs_to :tour
  belongs_to :venue, optional: true
end
