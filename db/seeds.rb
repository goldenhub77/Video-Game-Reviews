# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

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
