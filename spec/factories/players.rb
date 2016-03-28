FactoryGirl.define do
  factory :player do
    sequence(:name) { |n| "Team Player#{n}" }
    team
    user
  end
end
