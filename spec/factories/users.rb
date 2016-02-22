FactoryGirl.define do
  factory :user do
    first_name "john"
    last_name "doe"
    sequence(:email) { |n| "#{n}-#{Faker::Internet.email}"}
    password "secret"
  end
end
