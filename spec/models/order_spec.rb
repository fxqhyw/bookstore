require 'rails_helper'

RSpec.describe Order, type: :model do
  context 'associations' do
    %i[coupon shipping_address billing_address user delivery credit_card].each do |field|
      it { is_expected.to belong_to(field) }
    end
    it { is_expected.to have_many(:order_items) }
  end

  context 'validations' do
    it { is_expected.to validate_presence_of(:status) }
    it { is_expected.to validate_presence_of(:total_price) }
    it { is_expected.to validate_numericality_of(:total_price).is_greater_than(0) }
  end
end
