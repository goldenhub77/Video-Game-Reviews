require 'rails_helper'

RSpec.describe AdminsHelper, type: :helper do
    describe ".admin_controller?" do
      it "returns true or false if you are calling a admins controller" do
        expect(AdminsController.admin_controller?.to eq(true)
        expect(Admins::ReviewsController.admin_controller?.to eq(true)
        expect(Admins::VideoGamesController.admin_controller?.to eq(true)
        expect(VideoGamesController.admin_controller?.to eq(false)
        expect(ReviewsController.admin_controller?.to eq(false)
        expect(SearchController.admin_controller?.to eq(false)
        expect(UsersController.admin_controller?.to eq(false)
      end
    end
  end
end
