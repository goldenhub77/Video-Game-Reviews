require 'rails_helper'

RSpec.describe VideoGame, type: :model do
  describe '.create' do
    let!(:user) { FactoryGirl.create(:user) }
    let!(:platform) { FactoryGirl.create(:platform) }
    let!(:genre) { FactoryGirl.create(:genre) }

    scenario 'successfully' do

      video_game = VideoGame.create(
        title: "Overwatch",
        developer: "Blizzard Entertainment",
        description: "Fantastic, frantic shooter with some violence, open chat.",
        platforms: [platform],
        genre_id: genre.id,
        release_date: Date.parse('2016-05-20'),
        rating: 4,
        user_id: user.id
      )

      expect(video_game.valid?).to be_truthy
      expect(video_game.errors).to be_empty
    end

    scenario 'fails' do
      video_game = VideoGame.create(
        title: "",
        developer: "",
        description: "",
        platforms: [],
        genre_id: "",
        release_date: "",
        rating: "abc",
        user_id: nil
      )

      expect(video_game.valid?).to be_falsey
      expect(video_game.errors.full_messages).to include("Title can't be blank")
      expect(video_game.errors.full_messages).to include("Title is too short (minimum is 5 characters)")
      expect(video_game.errors.full_messages).to include("Developer can't be blank")
      expect(video_game.errors.full_messages).to include("Description is too short (minimum is 15 characters)")
      expect(video_game.errors.full_messages).to include("Platforms can't be blank")
      expect(video_game.errors.full_messages).to include("Release date can't be blank")
      expect(video_game.errors.full_messages).to include("Rating is not a number")
      expect(video_game.errors.full_messages).to include("Genre can't be blank")
      expect(video_game.errors.full_messages).to include("User must exist")
    end
  end

  describe ".destroy" do
    let!(:user) { FactoryGirl.create(:user) }
    let!(:reviewer) { FactoryGirl.create(:user) }
    let!(:platform) { FactoryGirl.create(:platform) }
    let!(:genre) { FactoryGirl.create(:genre) }
    let!(:video_game) { FactoryGirl.create(:video_game, user_id: user.id) }
    let!(:review) { FactoryGirl.create(:review, user_id: reviewer.id, video_game: video_game)}

    scenario "deletes a video game from database" do
      expect(VideoGame.all.first.id).to eq(video_game.id)
      expect(video_game.reviews.first.id).to eq(review.id)
      expect(reviewer.reviews.first.id).to eq(review.id)

      VideoGame.destroy(video_game.id)
      expect(VideoGame.where("id = ?", video_game.id)).to be_empty
      expect(Review.where("id = ?", review.id)).to be_empty
    end
  end
end
