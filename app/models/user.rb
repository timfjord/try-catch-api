class User < ApplicationRecord
  has_secure_password
  enum role: [:guest, :user, :admin]

  validates :email, presence: true, uniqueness: true
  validates :password, length: { minimum: 6 }

  def self.authenticated?(email, password)
    email.present? &&
      password.present? &&
      (user = User.find_by(email: email)) &&
      user.authenticate(password)
  end
end
