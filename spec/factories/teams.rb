FactoryGirl.define do
  factory :team do
    sequence(:name) { |n| "Team#{n}" }
    user
  end
end
