require 'rails_helper'

RSpec.describe Genre, type: :model do
  describe '.create' do
    it 'succeeds' do
      genre = Genre.create(name: 'Shooter')
      genre_two = Genre.create(name: 'Shooter', abbr: 'FPS') 

      expect(genre.valid?).to eq(true)
      expect(genre.name).to eq('Shooter')
      expect(genre.abbr).to eq(nil)

      expect(genre_two.valid?).to eq(true)
      expect(genre_two.name).to eq('Shooter')
      expect(genre_two.abbr).to eq('FPS')
    end

    it 'fails' do
      genre_fail = Genre.create()
      expect(genre_fail.valid?).to eq(false)
      expect(genre_fail.name).to eq(nil)
    end
  end
end
