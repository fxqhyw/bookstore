require 'rails_helper'

RSpec.describe Delivery, type: :model do
  context 'associations' do
    it { is_expected.to have_many(:orders) }
  end
end
