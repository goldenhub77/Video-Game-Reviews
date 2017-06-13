require 'rails_helper'

RSpec.describe Review, type: :model do
  describe '.create' do
    let!(:user) { FactoryGirl.create(:user) }
    let!(:platform) { FactoryGirl.create(:platform) }
    let!(:genre) { FactoryGirl.create(:genre) }
    let!(:video_game) { FactoryGirl.create(:video_game, user_id: user.id)}

    scenario 'successfully' do

      review = Review.create(
        title: "Overwatch",
        review: Faker::Lorem.paragraph,
        platforms: [platform],
        rating: 4,
        user_id: user.id,
        video_game: video_game
      )

      expect(review.valid?).to be_truthy
      expect(review.errors).to be_empty
    end

    scenario 'fails' do
      review = Review.create(
        title: "",
        review: "",
        platforms: [],
        rating: "abc",
        user_id: nil,
        video_game: nil
      )

      expect(review.valid?).to be_falsey
      expect(review.errors.full_messages).to include("Title can't be blank")
      expect(review.errors.full_messages).to include("Review can't be blank")
      expect(review.errors.full_messages).to include("Platforms can't be blank")
      expect(review.errors.full_messages).to include("Rating is not a number")
      expect(review.errors.full_messages).to include("User must exist")
      expect(review.errors.full_messages).to include("Video game must exist")
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
      expect(VideoGame.first.id).to eq(video_game.id)
      expect(video_game.reviews.first.id).to eq(review.id)
      expect(reviewer.reviews.first.id).to eq(review.id)
      User.destroy(user.id)
      expect(user.video_games).not_to be_empty
      expect(reviewer.reviews).not_to be_empty
      Review.destroy(review.id)
      expect(reviewer.reviews).to be_empty
    end
  end
end
