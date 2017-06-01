FactoryGirl.define do
  factory :user do
    first_name 'John'
    last_name 'Smith'
    sequence(:email) { |n| "gamefan#{n}@gmail.com" }
    password 'password'
    password_confirmation 'password'
    role 'member'
  end
end
