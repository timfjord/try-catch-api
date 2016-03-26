require 'rails_helper'

RSpec.describe ApplicationController do
  controller do
    before_action :authenticate_user!

    def index
    end
  end

  describe '#authenticate_user!' do
    it 'should raise error for not authenticated users' do
      get :index

      expect(response).not_to be_success
      expect(response.status).to eql 401
    end

    it 'should be success if data is valid' do
      sign_in

      get :index

      expect(response).to be_success
    end
  end
end
