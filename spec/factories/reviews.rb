FactoryGirl.define do
  factory :review do
    sequence(:title) { |n| "This is test title #{n}"}
    review { Faker::Lorem.paragraph(3) }
    platforms { Platform.first(rand(1..Platform.count)) }
    rating { Random.rand(0..5) }
  end
end
