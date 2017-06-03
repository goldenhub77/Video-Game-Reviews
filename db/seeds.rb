# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
PLATFORMS =
[
  { name: 'Windows' },
  { name: 'Mac' },
  { name: 'Linux' },
  { name: 'Xbox' },
  { name: 'Xbox 360' },
  { name: 'Xbox One' },
  { name: 'Playstation' },
  { name: 'Playstation 2' },
  { name: 'Playstation 3' },
  { name: 'Playstation 4' },
  { name: 'Android' },
  { name: 'IOS' }
]

GENRES =
[
  { name: 'First Person Shooter', abbr: 'FPS' },
  { name: 'Adventure', abbr: 'ADV' },
  { name: 'Role Playing Game', abbr: 'RPG' },
  { name: 'Puzzle'},
  { name: 'Simulation', abbr: 'SIM' },
  { name: 'Strategy' },
  { name: 'Sports' },
  { name: 'Fighting' },
  { name: 'Survival' }
]

10.times do
  user = FactoryGirl.build(:user)
  if User.where('email = ?', user.email).empty?
    user.save
    10.times do
      video_game = FactoryGirl.build(:video_game)
      if VideoGame.where('title = ?', video_game.title).empty?
        video_game.user_id = user.id
        video_game.save
      end
    end
  end
end

PLATFORMS.each do |platform|
  Platform.find_or_create_by(name: platform[:name])
end

GENRES.each do |genre|
  Genre.find_or_create_by(name: genre[:name], abbr: genre[:abbr])
end
