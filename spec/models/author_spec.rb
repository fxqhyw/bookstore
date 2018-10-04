require 'rails_helper'

RSpec.describe Author, type: :model do
  context 'associations' do
    it { is_expected.to have_and_belong_to_many(:books) }
  end

  context 'validations' do
    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }
  end
end
