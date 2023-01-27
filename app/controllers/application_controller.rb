class ApplicationController < ActionController::Base
  before_action :set_search, :set_open_request
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :create_admin
  before_action :markdown

  def force_to_pay
    return unless user_signed_in? && current_user.deposit_to_pay?

    redirect_to root_url
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  def markdown
    @markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, tables: true)
  end

  private

  def create_admin
    admin_email = 'admin@neumann.xyz'

    unless User.exists?(0)
      User.create(id: 0, name: 'neumann', email: admin_email, password: '123456',
                  password_confirmation: '123456')
    end
    return if AdminEmail.where(email: admin_email).exists?

    AdminEmail.create(email: admin_email)
  end

  def set_open_request
    @users_request = if user_signed_in? && current_user.has_request_open?
                       current_user.rental_requests.find_by(status: 'open')
                     end
  end

  def set_search
    @q = Game.ransack(params[:q])
  end
end
