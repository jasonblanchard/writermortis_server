FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "email#{n}@example.com" }
    password 'testpass'
    sequence(:username) { |n| "user#{n}" }
  end

end
