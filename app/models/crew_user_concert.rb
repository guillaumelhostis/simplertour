class CrewUserConcert < ApplicationRecord
  belongs_to :crew_user
  belongs_to :concert
  before_destroy :remove_associations
  validates_uniqueness_of :concert_id, scope: :crew_user_id

  private

  def remove_associations
    transport_user = TransportUser.find_by(user_id: CrewUser.find(self.crew_user_id).user_id)
    transport_user.destroy if transport_user != nil
    hotel_user = ConcertHotelUser.find_by(user_id: CrewUser.find(self.crew_user_id).user_id)
    hotel_user.destroy if hotel_user != nil
  end
end
