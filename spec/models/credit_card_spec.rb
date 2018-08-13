require 'rails_helper'

RSpec.describe CreditCard, type: :model do
  context 'associations' do
    it { is_expected.to belong_to(:order) }
  end

  context 'validations' do
    %i[first_name last_name number expiration_date cvv].each do |field|
      it { is_expected.to validate_presence_of(field) }
    end

    %i[first_name last_name].each do |field|
      it { is_expected.to validate_length_of(field).is_at_most(30) }
    end

    it { is_expected.to validate_length_of(:number).is_at_least(13).is_at_most(18) }
    it { is_expected.to validate_length_of(:expiration_date).is_equal_to(5) }
    it { is_expected.to validate_length_of(:cvv).is_equal_to(3) }
  end
end
