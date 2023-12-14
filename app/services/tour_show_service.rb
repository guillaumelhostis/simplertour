class TourShowService

  def initialize(tour)
    @tour = tour
    @current_date = Date.current
    @concerts = @tour.concerts
    @concert_dates = []
    @concert_index = []
    @concert_status = []
  end

  def call
    set_crew
    build_concert_dates
    build_concert_index
    build_concert_status
    build_today_concert
    build_upcoming_concert
  end

  def concerts
    @concerts
  end

  def crew
    @crew
  end

  def crew_users
    @crew_users
  end

  def concert_dates
    @concert_dates
  end

  def concert_index
    @concert_index
  end

  def concert_status
    @concert_status
  end

  def today_concerts
    @today_concerts
  end

  def upcoming_concerts
    @upcoming_concerts
  end

  private

  def set_crew
    @crew = Crew.find(@tour.crew_id)
    @crew_users = @crew.users
  end

  def build_concert_dates
    @concerts.each do |concert|
      @concert_dates << concert.date.strftime("%B %e, %Y").gsub(/[[:space:]]/, '')
    end
  end

  def build_concert_index
    @concerts.each do |concert|
      @concert_index << concert.id
    end
  end

  def build_concert_status
    @concerts.each do |concert|
      status = concert.calculate_status
      concert.status = status
      concert.save
      @concert_status << concert.status
    end
  end

  def build_today_concert
    @today_concerts = @concerts.select { |concert| concert.date == @current_date}
  end

  def build_upcoming_concert
    @upcoming_concerts =  @concerts.select { |concert| concert.date > @current_date }
    @upcoming_concerts = @upcoming_concerts.sort_by { |concert| concert.date }
  end
end
