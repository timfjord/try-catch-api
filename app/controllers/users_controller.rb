class UsersController < ApplicationController
  def sign_in
    User.authenticate! sign_in_params[:email], sign_in_params[:password]
    head :ok
  rescue Errors::UnauthorizedError
    head :unprocessable_entity
  end

  private

  def sign_in_params
    params.require(:user).permit :email, :password
  end
end
