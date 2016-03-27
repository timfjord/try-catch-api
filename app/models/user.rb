class User < ApplicationRecord
  has_secure_password
  enum role: [:guest, :user, :admin]

  has_many :teams
  has_many :players

  validates :email, presence: true, uniqueness: true
  validates :password, length: { minimum: 6 }

  def self.authenticate!(email, password)
    email.present? &&
      password.present? &&
      (user = User.find_by(email: email)) &&
      user.authenticate(password) &&
      user ||
      raise(Errors::UnauthorizedError)
  end
end
