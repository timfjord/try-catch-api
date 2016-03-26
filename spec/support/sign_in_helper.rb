module SignInHelper
  extend ActiveSupport::Concern

  class_methods do
    def sign_in(who = :user)
      let(:current_user) { FactoryGirl.create(who) }
      before(:each) { sign_in current_user }
    end
  end

  def sign_in(user = nil)
    user ||= FactoryGirl.create :guest
    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(user.email, user.password)
  end
end
