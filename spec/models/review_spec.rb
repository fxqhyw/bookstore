require 'rails_helper'

RSpec.describe Review, type: :model do
  context 'associations' do
    it { is_expected.to belong_to(:book) }
    it { is_expected.to belong_to(:user) }
  end

  context 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:rating) }
    it { is_expected.to validate_presence_of(:status) }
    it { is_expected.to validate_length_of(:title).is_at_most(50) }
    it { is_expected.to validate_length_of(:description).is_at_most(500) }
    it { is_expected.to validate_numericality_of(:rating).is_greater_than(0).is_less_than_or_equal_to(5) }  
  end
end
