require 'rails_helper'

RSpec.describe Book, type: :model do
  context 'associations' do
    it { is_expected.to have_and_belong_to_many(:authors) }
    it { is_expected.to belong_to(:category) }
  end

  context 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:price) }
    it { is_expected.to validate_numericality_of(:price).is_greater_than(0) }
    it { is_expected.to validate_presence_of(:published_at) }
    it { is_expected.to validate_numericality_of(:published_at).is_less_than_or_equal_to(Time.current.year) }
    it { is_expected.to validate_presence_of(:height) }
    it { is_expected.to validate_numericality_of(:height).is_greater_than(0) }
    it { is_expected.to validate_presence_of(:width) }
    it { is_expected.to validate_numericality_of(:width).is_greater_than(0) }
    it { is_expected.to validate_presence_of(:depth) }
    it { is_expected.to validate_numericality_of(:depth).is_greater_than(0) }
  end
end
