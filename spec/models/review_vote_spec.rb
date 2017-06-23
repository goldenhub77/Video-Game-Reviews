require 'rails_helper'

RSpec.describe ReviewVote, type: :model do
  describe '.create' do
    let!(:user) { FactoryGirl.create(:user) }
    let!(:platform) { FactoryGirl.create(:platform) }
    let!(:genre) { FactoryGirl.create(:genre) }
    let!(:video_game) { FactoryGirl.create(:video_game, user_id: user.id)}
    let!(:review) { FactoryGirl.create(:review, user_id: user.id, video_game_id: video_game.id) }

    scenario 'successfully' do

      review_vote = ReviewVote.create(
        vote: 1,
        user_id: user.id,
        review_id: review.id
      )

      expect(review_vote.valid?).to be_truthy
      expect(review_vote.errors).to be_empty
    end

    scenario 'fails' do
      review_vote = ReviewVote.create(
      vote: "",
      user_id: "",
      review_id: ""
      )

      expect(review_vote.valid?).to be_falsey
      expect(review_vote.errors.full_messages).to include("User must exist")
      expect(review_vote.errors.full_messages).to include("Review must exist")
      expect(review_vote.errors.full_messages).to include("Vote can't be blank")
      expect(review_vote.errors.full_messages).to include("Vote is not included in the list")
      expect(review_vote.errors.full_messages).to include("User can't be blank")
      expect(review_vote.errors.full_messages).to include("User is not a number")
      expect(review_vote.errors.full_messages).to include("Review can't be blank")
      expect(review_vote.errors.full_messages).to include("Review is not a number")
    end
  end

  describe ".destroy" do
    let!(:user) { FactoryGirl.create(:user) }
    let!(:platform) { FactoryGirl.create(:platform) }
    let!(:genre) { FactoryGirl.create(:genre) }
    let!(:video_game) { FactoryGirl.create(:video_game, user_id: user.id) }
    let!(:review) { FactoryGirl.create(:review, user_id: user.id, video_game: video_game)}
    let!(:review_vote) { FactoryGirl.create(:review_vote, user_id: user.id, review_id: review.id)}

    scenario "deletes a review from database" do
      expect(ReviewVote.first.id).to eq(review_vote.id)
      ReviewVote.destroy(review_vote.id)
      expect(ReviewVote.all).to be_empty
    end
  end
end
