require 'rails_helper'

RSpec.describe VideoGame, type: :model do
  describe '.create' do
    let!(:user) { FactoryGirl.create(:user) }

    it 'successfully' do

      video_game = VideoGame.create(
        title: "Overwatch",
        developer: "Blizzard Entertainment",
        description: "Fantastic, frantic shooter with some violence, open chat.",
        platforms: ["Mac", "PlayStation 4", "Windows", "Xbox One"],
        genre: "Shooter",
        release_date: Date.parse('2016-05-20'),
        rating: 95,
        price: 59.99,
        user_id: user.id
      )
      expect(video_game.valid?).to be_truthy
      expect(video_game.errors).to be_empty
    end

    it 'fails' do
      video_game = VideoGame.create(
        title: "",
        developer: "",
        description: "",
        platforms: "",
        genre: "",
        release_date: "",
        rating: "abc",
        price: "abc",
        user_id: user.id
      )
      expect(video_game.valid?).to be_falsey
      expect(video_game.errors.full_messages).to include(
        "Title can't be blank",
        "Title is too short (minimum is 5 characters)",
        "Developer can't be blank", "Description is too short (minimum is 15 characters)",
        "Platforms can't be blank", "Genre can't be blank",
        "Release date can't be blank", "Rating is not a number", "Price is not a number"
      )
    end
  end
end
