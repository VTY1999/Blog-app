class ApplicationController < ActionController::Base
  include JsonWebToken

  protect_from_forgery with: :exception

  skip_before_action :verify_authenticity_token, if: :json_request?

  before_action :update_allowed_parameters, if: :devise_controller?

  before_action :authenticate_request

  skip_before_action :authenticate_request, if: :html_request?

  protected

  def update_allowed_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |u|
      u.permit(:name, :email, :password, :email_confirmation, :password_confirmation)
    end
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :email, :password, :current_password) }
  end

  def authenticate_request
    header = request.headers['Authorization']
    header = header.split.last if header
    decoded = jwt_decode(header)
    @current_user = User.find(decoded[:user_id])
  end

  def json_request?
    request.format.json?
  end

  def html_request?
    request.format.html?
  end
end
