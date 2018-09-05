require 'rails_helper'

RSpec.describe Book, type: :model do
  context 'associations' do
    it { is_expected.to have_and_belong_to_many(:authors) }
    it { is_expected.to belong_to(:category).counter_cache(true) }
    it { is_expected.to have_many(:order_items).dependent(:destroy) }
    it { is_expected.to have_many(:reviews).dependent(:destroy) }
  end

  context 'validations' do
    %i[title description price published_at height width depth quantity materials].each do |field|
      it { is_expected.to validate_presence_of(field) }
    end

    %i[price height width depth quantity].each do |field|
      it { is_expected.to validate_numericality_of(field).is_greater_than_or_equal_to(0.01) }
    end

    it { is_expected.to validate_numericality_of(:published_at).is_less_than_or_equal_to(Time.current.year) }
  end
end
