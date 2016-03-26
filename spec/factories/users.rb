FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "email#{n}@example.com" }
    password '12345678'

    factory :guest do
      role 'guest'
    end

    factory :regular do
      role 'user'
    end

    factory :admin do
      role 'admin'
    end
  end
end
