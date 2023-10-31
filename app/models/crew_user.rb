class CrewUser < ApplicationRecord
  belongs_to :user
  belongs_to :crew
  has_many :crew_user_concerts
  has_many :concerts, through: :crew_user_concerts
  before_destroy :delete_crew_user_concert

  private

  def delete_crew_user_concert
    crew_user_concerts.each do |crew_user_concert|
      crew_user_concert.update(concert_id: nil, crew_user: nil)
      crew_user_concert.destroy
    end
  end

end
