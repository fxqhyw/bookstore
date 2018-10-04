require 'rails_helper'

RSpec.describe Review, type: :model do
  context 'associations' do
    it { is_expected.to belong_to(:book) }
    it { is_expected.to belong_to(:user) }
  end

  context 'validations' do
    %i[title description rating status].each do |field|
      it { is_expected.to validate_presence_of(field) }
    end

    it { is_expected.to validate_length_of(:title).is_at_most(80) }
    it { is_expected.to validate_length_of(:description).is_at_most(500) }
    it { is_expected.to validate_numericality_of(:rating).is_greater_than(0).is_less_than_or_equal_to(5) }  
  end
end
