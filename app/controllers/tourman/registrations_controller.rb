# frozen_string_literal: true

class Tourman::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]
  skip_before_action :verify_authenticity_token

  # GET /resource/sign_up
  def new
    @phoneprefix = ISO3166::Country.all.map { |country| "#{country.country_code}" }
    @phoneprefixsorted = @phoneprefix.uniq.sort_by(&:to_i).map {|c| "+#{c}"}
    super
  end

  # POST /resource
  def create
    super
  end

  # GET /resource/edit
  def edit
    @concert_templates = ConcertTemplate.where(tourman_id: current_tourman.id)
    @tours = Tour.where(tourman_id: current_tourman.id)
    @phoneprefix = ISO3166::Country.all.map { |country| "#{country.country_code}" }
    @phoneprefixsorted = @phoneprefix.uniq.sort_by(&:to_i).map {|c| "+#{c}"}
    super
  end

  # PUT /resource
  def update
    @concert_templates = ConcertTemplate.where(tourman_id: current_tourman.id)
    @tours = Tour.where(tourman_id: current_tourman.id)
    super
  end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  #If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:picture])
  end

  #If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:picture])
  end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
