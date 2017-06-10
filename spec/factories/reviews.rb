FactoryGirl.define do
  factory :review do
    sequence(:title) { |n| "This is test title #{n}"}
    review { Faker::Lorem.paragraph }
    platform_ids { [Random.rand(1..Platform.all.count).to_s] }
    rating { Random.rand(0..5) }
  end
end
