class PagesController < ApplicationController
  before_action :authenticate_user!, only: [:user]
  before_action :authenticate_tourman!, only: [:tourman]
  before_action :set_concerts, only: [:user]

  def home
  end

  def user

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
