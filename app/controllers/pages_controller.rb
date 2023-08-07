class PagesController < ApplicationController
  before_action :authenticate_user!, only: [:user]
  before_action :authenticate_tourman!, only: [:tourman]

  def home
  end

  def user
  end

  def tourman
  end
end
