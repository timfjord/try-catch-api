class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Basic::ControllerMethods

  private

  def authenticate_user!
    unless authenticate_with_http_basic(&User.method(:authenticated?))
      head :unauthorized
    end
  end
end
