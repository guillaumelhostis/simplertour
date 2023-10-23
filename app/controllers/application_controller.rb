class ApplicationController < ActionController::Base
  before_action :authenticate!
  before_action :configure_permitted_parameters, if: :devise_controller?
  include Pundit::Authorization

  after_action :verify_authorized, except: :index, unless: :skip_pundit?
  after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?


  protect_from_forgery with: :exception

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(root_path)
  end

  def pundit_user
    AuthorizationContext.new(current_user, current_tourman)
  end

  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :birth_day, :address, :post_code, :city, :phone_number, :country ])

    # For additional in app/views/devise/registrations/edit.html.erb
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :birth_day, :address, :post_code, :city, :phone_number, :country ])
  end

  def after_sign_in_path_for(resource)
    if current_tourman
      stored_location_for(resource) ||  pages_tourman_path
    elsif current_user
      stored_location_for(resource) || root_path
    end
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
