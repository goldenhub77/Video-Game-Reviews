FactoryGirl.define do
  factory :video_game do
    sequence(:title) { |n| "Overwatch vol.#{n}"}
    developer "Blizzard Entertainment"
    description "Fantastic, frantic shooter with some violence, open chat."
    platforms ['platform']
    genre "genre"
    release_date Date.parse('2016-05-20')
    rating 95
  end
end
