FactoryGirl.define do
  random_platform = Random.rand(1..Platform.all.count).to_s
  random_genre = Random.rand(1..Genre.all.count).to_s
  random_rating = Random.rand(0..5)
  factory :video_game do
    sequence(:title) { |n|  "#{Faker::Team.name}#{n}" }
    developer { Faker::Company.name }
    description { Faker::Lorem.paragraph }
    platform_ids { [random_platform, random_platform, random_platform] }
    genre_id { random_genre }
    release_date { Date.parse('2016-05-20') }
    rating { random_rating }
  end
end
