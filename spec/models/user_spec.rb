require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to validate_presence_of :email }
  it { is_expected.to validate_uniqueness_of :email }
  it { is_expected.to validate_length_of(:password).is_at_least 6 }
  it { is_expected.to define_enum_for(:role).with [:guest, :user, :admin] }
  it { is_expected.to have_secure_password }

  describe '.authenticated?' do
    it 'should be falsy if email or password are blank or no users present' do
      expect(User).not_to be_authenticated '', 'password'
      expect(User).not_to be_authenticated 'email', ''
      expect(User).not_to be_authenticated 'email@email.com', 'password'
    end

    it 'should be falsy if password is invalid' do
      user = create :user, password: '12345678'
      expect(User).not_to be_authenticated user.email, 'wrong_password'
    end

    it 'should be truthy if email and password are valid' do
      user = create :user
      expect(User).to be_authenticated user.email, user.password
    end
  end
end
