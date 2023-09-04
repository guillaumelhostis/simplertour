class Tour < ApplicationRecord
  belongs_to :tourman
  belongs_to :crew, dependent: :destroy
  has_many :concerts, dependent: :destroy
  accepts_nested_attributes_for :concerts
  has_one_attached :picture


end
