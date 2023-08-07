class ApplicationController < ActionController::Base
  before_action :authenticate!
  include Pundit::Authorization
  after_action :verify_authorized, except: :index, unless: :skip_pundit?
  after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?


  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(root_path)
  end

  def pundit_user
    AuthorizationContext.new(current_user, current_tourman)
  end

  private

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
  end

  def authenticate!
    if @current_user == current_tourman
        :authenticate_tourman!
    elsif @current_user == current_user
        :authenticate_user!
    end
  end
end
