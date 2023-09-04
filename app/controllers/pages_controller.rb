class PagesController < ApplicationController
  before_action :authenticate_user!, only: [:user]
  before_action :authenticate_tourman!, only: [:tourman]

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
end
