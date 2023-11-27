class PagesController < ApplicationController
  before_action :authenticate_user!, only: [:user]
  before_action :authenticate_tourman!, only: [:tourman]
  before_action :set_concerts, only: [:user_dashboard, :user_concert_dashboard]

  def home
  end

  def user_dashboard
    current_date = Date.current
    @upcoming_concerts = @concerts.select { |concert| concert.date > current_date }
    @upcoming_concerts = @upcoming_concerts.sort_by { |concert| concert.date }
    @today_concerts = @concerts.select { |concert| concert.date == current_date }
  end

  def user_concert_dashboard
    @phoneprefix = ISO3166::Country.all.map { |country| "#{country.country_code}" }
    @phoneprefixsorted = @phoneprefix.uniq.sort_by(&:to_i).map {|c| "+#{c}"}
    @concert = Concert.find(params[:data_concert].to_i)
    @tour = Tour.find(params[:data_tour].to_i)
    @timetable_entries = TimetableEntry.where(concert_id: @concert).order(hourminute: :asc)
    @user_transports = @concert.transports.select { |transport| transport.users.include?(current_user) }
    @user_hotels =  []
    @concert.concert_hotels.each do |concert_hotel|
      @user_hotels << concert_hotel if concert_hotel.users.include?(current_user)
    end
    @crew = @tour.crew
    @crew_users = @crew.users
    @guests = @concert.guests
    @contacts = @concert.contacts
    @hotel_geocoders = []
    @venue_geocoders = []
    if @concert.venue_id.present?
      @venue = Venue.find(@concert.venue_id)
      @venue_geocoders <<  @venue
    end
    if @user_hotels.present?
      hotel_ids_array = @user_hotels.pluck(:hotel_id)
      hotel_ids_array.each do |hotel|
        @hotel_geocoders <<  Hotel.find(hotel)
      end
    end
    @hotel_markers =  @hotel_geocoders.map do |location|
      {
        lat: location.latitude,
        lng: location.longitude,
        marker_html: render_to_string(partial: "hotel_marker")
      }
    end
    @venue_markers =  @venue_geocoders.map do |location|
      {
        lat: location.latitude,
        lng: location.longitude,
        marker_html: render_to_string(partial: "venue_marker")
      }
    end
  end

  def tourman
    @tours = Tour.where(tourman_id: current_tourman.id)
  end

  def search
    query = params[:query]
    @users = User.where('LOWER(first_name) LIKE :query OR LOWER(last_name) LIKE :query', query: "%#{query.downcase}%")
    render json: @users
  end

  private

  def set_concerts
    @crews = Crew.all
    user_crews = @crews.select { |crew| crew.users.include?(current_user) }
    @tours = []
    user_crews.each { |user_crew| @tours << Tour.find_by(crew_id: user_crew.id ) }
    @concerts = []
    @tours.each { |tour| @concerts << Concert.where(tour_id: tour.id) }
    @concerts = @concerts.flatten
  end
end
