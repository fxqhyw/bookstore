require 'rails_helper'

RSpec.describe ReviewDecorator do
  let(:user) { create(:user, email: 'john_doe@gmail.com') }
  let(:review) { create(:review, user: user).decorate }

  describe '#avatar_letter' do
    it 'returns capitalize first letter of user email' do
      expect(review.avatar_letter).to eq 'J'
    end
  end

  describe '#reviewer_name' do
    context 'user has entered his address data in the settings' do
      let(:address) { create(:address, first_name: 'John', last_name: 'Doe') }
      let(:review_with_username) { create(:review, user: address.user).decorate }

      it 'returns user full name string from address data' do
        expect(review_with_username.reviewer_name).to eq 'John Doe'
      end
    end

    context 'user has not entered his address data in the settings' do
      it 'returns user email' do
        expect(review.reviewer_name).to eq 'john_doe@gmail.com'
      end
    end
  end
end
