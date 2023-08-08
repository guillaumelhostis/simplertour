class Tour < ApplicationRecord
  belongs_to :tourman
  has_one :crew

end
