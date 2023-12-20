class CrewUserConcertCreationService

  def initialize(crew_user_concert_params, tour, concert)
    @crew_user_concert_params = crew_user_concert_params
    @tour = tour
    @concert = concert
    @success = false
  end

  def call
    build_crew_user_concert
    save_crew_user_concert if build_crew_user_concert
  end

  def success
    @success
  end

  def crew_user_concert
    @crew_user_concert
  end

  private

  def build_crew_user_concert
    @crew = Crew.find(@tour.crew_id)
    @crew_user = CrewUser.find_by(user_id: @crew_user_concert_params, crew_id: @crew.id )
    @crew_user_concert = CrewUserConcert.new(crew_user_id: @crew_user.id, concert_id: @concert.id)
  end

  def save_crew_user_concert
    @success = @crew_user_concert.save
  end

end
