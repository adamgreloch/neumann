class ApplicationController < ActionController::Base
  before_action :set_search, :set_open_request
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  private

  def set_open_request
    if user_signed_in? && current_user.has_request_open?
      @users_request = RentalRequest.find(current_user.rental_request_id)
    else
      @users_request = nil
    end
  end

  def set_search
    @q = Game.ransack(params[:q])
  end
end
