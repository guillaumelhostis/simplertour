class Transport < ApplicationRecord
  belongs_to :concert
  has_many :transport_users, dependent: :destroy
  has_many :users, through: :transport_users
  validates :time_of_depart, :time_of_arrival, :place_of_depart, :place_of_arrival, :way_of_transport, presence: true
  geocoded_by :place_of_arrival
  geocoded_by :place_of_depart
  after_validation :geocode_place_of_arrival, if: :will_save_change_to_place_of_arrival?
  after_validation :geocode_place_of_depart, if: :will_save_change_to_place_of_depart?

  WAY_OF_TRANSPORT_OPTIONS = ["Train", "Bus", "Car", "Flight", "Van", "Trailer", "Other"]

  private

  def geocode_place_of_arrival
    if place_of_arrival.present?
      result = Geocoder.search(place_of_arrival).first
      if result
        self.arrival_latitude = result.latitude
        self.arrival_longitude = result.longitude
      end
    end
  end

  def geocode_place_of_depart
    if place_of_depart.present?
      result = Geocoder.search(place_of_depart).first
      if result
        self.depart_latitude = result.latitude
        self.depart_longitude = result.longitude
      end
    end
  end
end
