FactoryGirl.define do
  factory :platform do
    sequence(:name) { |n| "platform#{n}" }
  end
end
