require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  context 'associations' do
    it { is_expected.to belong_to(:book) }
    it { is_expected.to belong_to(:order) }
  end

  context 'validations' do
    it { is_expected.to validate_numericality_of(:quantity).is_greater_than(0) }
  end
end
