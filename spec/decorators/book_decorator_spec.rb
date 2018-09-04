require 'rails_helper'

RSpec.describe BookDecorator do
  describe '#dimensions_string' do
    let(:book) { create(:book, height: 1.1, width: 2.2, depth: 3.3).decorate }

    it 'returns dimensions string format' do
      expect(book.dimensions_string).to eq('H:1.1" x W:2.2" x D:3.3"')
    end
  end

  describe '#authors_list' do
    let(:first_author) { create(:author, first_name: 'Charles', last_name: 'Bukowski') }
    let(:second_author) { create(:author, first_name: 'Franz', last_name: 'Kafka') }
    let(:book) { create(:book, authors: [first_author, second_author]).decorate }

    it 'returns all authors of book in string format' do
      expect(book.authors_list).to eq('Charles Bukowski, Franz Kafka')
    end
  end
end
