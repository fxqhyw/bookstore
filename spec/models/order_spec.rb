require 'rails_helper'

RSpec.describe Order, type: :model do
  context 'associations' do
    %i[coupon user delivery credit_card].each do |field|
      it { is_expected.to belong_to(field) }
    end
    it { is_expected.to have_many(:order_items).dependent(:destroy) }
    it { is_expected.to have_many(:addresses) }
    it { is_expected.to have_one(:shipping_address).dependent(:destroy) }
    it { is_expected.to have_one(:billing_address).dependent(:destroy) }
  end

  context 'validations' do
    it { is_expected.to validate_presence_of(:status) }
    it { is_expected.to validate_presence_of(:total_price) }
    it { is_expected.to validate_numericality_of(:total_price).is_greater_than(0) }
  end
end
