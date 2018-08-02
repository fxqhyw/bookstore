require 'rails_helper'

RSpec.describe CartsController, type: :controller do
  let(:cart) { FactoryBot.create(:cart) }
  before { allow_any_instance_of(ApplicationController).to receive(:current_cart).and_return(cart) }

  describe 'GET #show' do
    before { get :show }

    it 'renders :show template' do
      expect(response).to render_template(:show)
    end
  end

  describe 'PUT #update' do
    context 'valid coupon' do
      let(:coupon) { FactoryBot.create(:coupon) }
      before { put :update, params: { coupon_code: coupon.code } }

      it 'redirects to carts#show' do
        expect(response).to redirect_to(cart_path)
      end

      it 'updates cart in the database' do
        cart.reload
        expect(cart.coupon).to eq(coupon)
      end

      it 'shows success message' do
        expect(flash[:notice]).to eq('Coupon was successfully added')
      end
    end

    context 'invalid coupon' do
      before { put :update, params: { coupon_code: 'fake' } }

      it 'redirects to carts#show' do
        expect(response).to redirect_to(cart_path)
      end

      it 'shows error message' do
        expect(flash[:notice]).to eq('Coupon is invalid')
      end
    end
  end
end
