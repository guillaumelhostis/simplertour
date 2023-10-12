class PagesController < ApplicationController
  before_action :authenticate_user!, only: [:user]
  before_action :authenticate_tourman!, only: [:tourman]
  before_action :set_concerts, only: [:user_dashboard]

  def home
  end

  def user_dashboard
    current_date = Date.current
    @upcoming_concerts = @concerts.select { |concert| concert.date > current_date }
    @upcoming_concerts = @upcoming_concerts.sort_by { |concert| concert.date }
    @today_concerts = @concerts.select { |concert| concert.date == current_date }
  end

  def user_concert_dashboard
    @concert = Concert.find(params[:data_concert].to_i)
    @tour = Tour.find(params[:data_tour].to_i)
    @timetable_entries = TimetableEntry.where(concert_id: @concert).order(hourminute: :asc)
    @user_transports = @concert.transports.select { |transport| transport.users.include?(current_user) }


  end

  def tourman
  end

  def search
    query = params[:query]

    # Implement your user search logic here, e.g., using ActiveRecord
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
