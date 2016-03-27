class Team < ApplicationRecord
  has_many :players
  belongs_to :user

  validates :name, presence: true
end
