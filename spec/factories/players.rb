FactoryGirl.define do
  factory :player do
    sequence(:name) { |n| "Team Player#{n}" }
    team { create :team }
    user { create :user }
  end
end
