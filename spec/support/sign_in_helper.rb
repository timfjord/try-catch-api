module SignInHelper
  extend ActiveSupport::Concern

  class_methods do
    def sign_in(who = :admin)
      let(:current_user) { FactoryGirl.create(who) }
      before(:each) { sign_in current_user }
    end
  end

  def sign_in(user = nil)
    @current_user = user || FactoryGirl.create(:admin)
  end

  [:get, :post, :put, :patch, :delete].each do |method|
    class_eval <<-CODE, __FILE__, __LINE__ + 1
      def #{method}(path, env: {}, **kwargs)
        env['HTTP_AUTHORIZATION'] = basic_auth_header if @current_user
        super path, env: env, **kwargs
      end
    CODE
  end

  private

  def basic_auth_header
    ActionController::HttpAuthentication::Basic.encode_credentials @current_user.email, @current_user.password
  end
end
