class UsersController < ApplicationController
  def sign_in
    if User.authenticated?(sign_in_params[:email], sign_in_params[:password])
      head :ok
    else
      head :unprocessable_entity
    end
  end

  private

  def sign_in_params
    params.require(:user).permit :email, :password
  end
end
