require 'rails_helper'

RSpec.describe CreditCard, type: :model do
  context 'associations' do
  end

  context 'validations' do
    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }
    it { is_expected.to validate_presence_of(:number) }
    it { is_expected.to validate_presence_of(:expiration_date) }
    it { is_expected.to validate_presence_of(:cvv) }
    it { is_expected.to validate_length_of(:number).is_equal_to(16) }
    it { is_equal_to.to validate_length_of(:first_name).is_at_most(20) }
    it { is_equal_to.to validate_length_of(:last_name).is_at_most(20) }
    it { is_expected.to validate_length_of(:expiration_date).is_at_most(5) }
    it { is_expected.to validate_length_of(:cvv).is_equal_to(3) }
  end
end
