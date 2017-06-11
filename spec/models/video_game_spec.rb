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
        platform_ids: [platform.id],
        genre_id: "genre",
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
        platform_ids: nil,
        genre_id: "",
        release_date: "",
        rating: "abc",
        user_id: ""
      )
      expect(video_game.valid?).to be_falsey
      expect(video_game.errors.full_messages).to include(
        "Title can't be blank",
        "Title is too short (minimum is 5 characters)",
        "Developer can't be blank", "Description is too short (minimum is 15 characters)",
        "Platforms can't be blank", "Genre can't be blank",
        "Release date can't be blank", "Rating is not a number"
      )
    end
  end

  describe ".destroy" do
    let!(:user) { FactoryGirl.create(:user) }
    let!(:platform) { FactoryGirl.create(:platform) }
    let!(:genre) { FactoryGirl.create(:genre) }
    let!(:video_game) { FactoryGirl.create(:video_game, user_id: user.id) }
    let!(:review) { FactoryGirl.create(:review, user_id: user.id)}

    scenario "deletes a video game from database" do
      VideoGamesReview.create(video_game_id: video_game.id, review_id: review.id)
      expect(VideoGame.all.first.id).to eq(video_game.id)
      expect(video_game.reviews.first.id).to eq(review.id)
      expect(user.reviews.first.id).to eq(review.id)

      User.destroy(user.id)
      expect(VideoGame.all).not_to be_empty
      expect(Review.all).not_to be_empty
      expect(VideoGamesReview.all).not_to be_empty
      VideoGame.destroy(video_game.id)
      expect(VideoGame.all).to be_empty
      expect(Review.all).not_to be_empty
      expect(VideoGamesReview.all).to be_empty
    end
  end
end
