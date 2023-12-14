class Tour < ApplicationRecord
  belongs_to :tourman
  belongs_to :crew, dependent: :destroy
  has_many :concerts, dependent: :destroy
  accepts_nested_attributes_for :concerts
  has_one_attached :picture
  before_destroy :remove_associations
  validates :title, :artist, :starting, :ending, :genre, presence: true

  private

  def remove_associations
    concerts.each do |concert|
      concert.update(tour_id: nil)
      concert.destroy
    end
  end
end
