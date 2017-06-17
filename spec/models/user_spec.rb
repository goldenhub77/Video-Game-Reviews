require 'rails_helper'

RSpec.describe User, type: :model do
  describe '.create' do
    scenario 'succeeds' do
      user = User.create(
        first_name: 'John',
        last_name: 'Smith',
        email: 'test123@abc.com',
        password: 'Pa$$word',
        password_confirmation: 'Pa$$word'
      )

      expect(user.valid?).to be_truthy
      expect(user.errors).to be_empty
    end
    scenario 'fails' do
      user = User.create(
        first_name: '',
        last_name: '',
        email: 'bademail',
        password: 'Pa$$word',
        password_confirmation: 'unmatched'
      )

      expect(user.valid?).to be_falsey
      expect(user.errors.messages).to eq({
        :email=>["is invalid"],
        :password_confirmation=>["doesn't match Password"],
        :first_name=>["can't be blank"],
        :last_name=>["can't be blank"]}
        )
    end
  end

  describe '.admin?' do
    scenario 'equals false' do
      user = User.create(
        first_name: 'John',
        last_name: 'Smith',
        email: 'test123@abc.com',
        password: 'Pa$$word',
        password_confirmation: 'Pa$$word'
      )
      expect(user.admin?).to be_falsey
    end
    scenario 'equals true' do
      user = User.create(
        first_name: 'John',
        last_name: 'Smith',
        email: 'test123@abc.com',
        role: 'admin',
        password: 'Pa$$word',
        password_confirmation: 'Pa$$word'
      )
      expect(user.admin?).to be_truthy
    end
  end

  describe '.destroy' do
    scenario 'user is destoyed from database' do
      user = User.create(
        first_name: 'John',
        last_name: 'Smith',
        email: 'test123@abc.com',
        role: 'admin',
        password: 'Pa$$word',
        password_confirmation: 'Pa$$word'
      )
      new_user = User.where(email: 'test123@abc.com').first
      expect(new_user).to eq(user)
      destroyed_user = User.destroy(user.id)
      expect(new_user).to eq(destroyed_user)
      expect(User.where(id: user.id)).to be_empty

    end
  end
end
