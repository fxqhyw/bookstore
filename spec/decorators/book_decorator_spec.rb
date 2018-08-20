require 'rails_helper'

RSpec.describe BookDecorator do
  describe '#dimensions_string' do
    let(:book) { FactoryBot.create(:book, height: 1.1, width: 2.2, depth: 3.3).decorate }

    it 'returns dimensions string format' do
      expect(book.dimensions_string).to eq('H:1.1" x W:2.2" x D:3.3"')
    end
  end
end
