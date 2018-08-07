require 'rails_helper'

RSpec.describe AddressesController, type: :controller do
  describe 'PUT #update' do
    let(:address) { FactoryBot.create(:address) }

    before do
      sign_in(address.user)
      put :update, params: { address: { user_id: address.user_id, type: address.type, zip: '123', country: 'Bookstoria' } }
    end

    context 'address exist' do
      it 'redirects to addresses#edit' do
        expect(response).to redirect_to(address_path)
      end

      it 'updates address' do
        address.reload
        expect(address.zip).to eq('123')
        expect(address.country).to eq('Bookstoria')
      end
    end

    context 'address does not exist' do
      it 'redirects to addresses#edit' do
        expect(response).to redirect_to(address_path)
      end
    end
  end
end
