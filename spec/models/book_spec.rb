require 'rails_helper'

RSpec.describe Book, type: :model do
  context 'associations' do
    it { is_expected.to have_and_belong_to_many(:authors) }
    it { is_expected.to belong_to(:category) }
  end

  context 'validations' do
    %i[title description price published_at height width depth].each do |field|
      it { is_expected.to validate_presence_of(field) }
    end

    %i[price height width depth].each do |field|
      it { is_expected.to validate_numericality_of(:width).is_greater_than(0) }
    end

    it { is_expected.to validate_numericality_of(:published_at).is_less_than_or_equal_to(Time.current.year) }
  end
end
