class VenueCreationService

  def initialize(venue_params, current_tourman, concert)
    @venue_params = venue_params
    @current_tourman = current_tourman
    @concert = concert
    @success = false
  end

  def call
    build_venue
    save_venue
    handle_concert_association
  end

  def success
    @success
  end

  def venue
    @venue
  end

  private

  def build_venue
    @venue = Venue.new(@venue_params.merge(tourman_id: @current_tourman.id))
  end

  def save_venue
    @success = @venue.save
  end

  def handle_concert_association
    associate_concert_with_venue if @concert.present?
  end

  def associate_concert_with_venue
    @concert.venue_id = @venue.id
    @concert.name = @venue.name
    @concert.save
  end
end
