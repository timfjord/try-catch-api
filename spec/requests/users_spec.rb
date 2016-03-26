require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'sign_in' do
    let(:params) do
      {
        user: {
          email: 'ev@fjord.com',
          password: '123456'
        }
      }
    end

    it 'should not be success if no users found' do
      post sign_in_users_path params

      expect(response).not_to be_success
    end

    it 'should not be success if password is invalid' do
      create :user, email: params[:user][:email], password: '12345678'

      post sign_in_users_path params

      expect(response).not_to be_success
    end

    it 'should be success if user found' do
      create :user, email: params[:user][:email], password: params[:user][:password]

      post sign_in_users_path params

      expect(response).to be_success
    end
  end
end
