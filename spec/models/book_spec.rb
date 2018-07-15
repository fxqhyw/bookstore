require 'rails_helper'

RSpec.describe Book, type: :model do
  context 'associations' do
    it { is_expected.to have_and_belong_to_many(:authors) }
  end

  context 'validations' do
    it { is_expected.to validate_presence_of :title }
    it { is_expected.to validate_presence_of :description }
    it { is_expected.to validate_presence_of :published_at }
    it { is_expected.to validate_presence_of :height }
    it { is_expected.to validate_presence_of :width }
    it { is_expected.to validate_presence_of :depth }
  end
end
