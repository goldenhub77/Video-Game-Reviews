FactoryGirl.define do
  factory :video_game do
    sequence(:title) { |n| "Overwatch vol.#{n}"}
    developer "Blizzard Entertainment"
    description "Fantastic, frantic shooter with some violence, open chat."
    platforms ["Mac", "PlayStation 4", "Windows", "Xbox One"]
    genre "Shooter"
    release_date Date.parse('2016-05-20')
    rating 95
    price 59.99
  end
end
