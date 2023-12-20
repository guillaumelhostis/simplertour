class TourCreationService

  def initialize(tour_params, current_tourman)
    @tour_params = tour_params
    @current_tourman = current_tourman
    @success = false
  end

  def call
    build_tour
    build_new_crew_associated
    save_tour
  end

  def tour
    @tour
  end

  def success
    @success
  end

  private

  def build_tour
    @tour = Tour.new(@tour_params.merge(tourman_id: @current_tourman.id))
  end

  def build_new_crew_associated
    @newcrew = Crew.new(name: "Team #{@tour.title}")
    @newcrew.save
    @tour.crew_id = @newcrew.id
  end

  def save_tour
    @success = @tour.save
  end
end
