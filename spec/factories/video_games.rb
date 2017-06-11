FactoryGirl.define do

  factory :video_game do
    sequence(:title) { |n|  "#{Faker::Team.name}#{n}" }
    developer { Faker::Company.name }
    description { Faker::Lorem.paragraph }
    platforms { Platform.first(rand(1..Platform.count)) }
    genre { Genre.first }
    release_date { Date.parse('2016-05-20') }
    rating { Random.rand(1..5) }
  end
end
