class ApplicationController < ActionController::API
  attr_reader :current_user

  include ActionController::HttpAuthentication::Basic::ControllerMethods
  include ActionController::Serialization
  include Pundit

  rescue_from Pundit::NotAuthorizedError do
    head :unauthorized
  end

  private

  def authenticate_user!
    if user = authenticate_with_http_basic(&User.method(:authenticate!))
      @current_user = user
    else
      head :unauthorized
    end
  end
end
