require 'rails_helper'

RSpec.describe Platform, type: :model do
  describe '.create' do
    scenario 'succeeds' do
      platform = Platform.create(name: 'Windows')
      expect(platform.valid?).to eq(true)
      expect(platform.name).to eq('Windows')
    end

    scenario 'fails' do
      platform_fail = Platform.create()
      expect(platform_fail.valid?).to eq(false)
      expect(platform_fail.name).to eq(nil)
    end
  end
end
