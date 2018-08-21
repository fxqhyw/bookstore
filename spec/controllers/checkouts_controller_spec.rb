require 'rails_helper'

RSpec.describe CheckoutsController, type: :controller do
  describe 'GET #show' do
    context 'cart is not empty' do
      %i[login address delivery payment confirm].each do |step|
        it "renders #{step} template" do
          allow(controller).to receive(:empty_cart?) { false }
          stepper = instance_double(CheckoutStepper, call: step)
          allow(CheckoutStepper).to receive(:new) { stepper }
          get :show, params: { id: step }
          expect(response).to render_template(step)
        end
      end
    end

    context 'cart is empty' do
      it 'redirects to cart path if cart is empty' do
        allow(controller).to receive(:empty_cart?) { true }
        get :show, params: { id: :address }
        expect(response).to redirect_to(cart_path)
      end
    end
  end

  describe 'PUT #update' do
    let(:user) { FactoryBot.create(:user) }
    let(:valid_params) { FactoryBot.attributes_for(:address, user_id: user.id) }
    let(:invalid_params) { FactoryBot.attributes_for(:address, zip: 'qwerty', phone: 'no phone(', user_id: user.id) }
    before { sign_in(user) }

    describe 'address step' do
      context 'valid params' do
        context 'without use billing' do
          it 'saves order addresses' do
            expect {
              put :update, params: { id: :address, use_billing: { 'true': '0' },
                                     billing: valid_params, shipping: valid_params }
            }.to change(Address, :count).by(2)
          end

          it 'redirects to delivery step' do
            put :update, params: { id: :address, use_billing: { 'true': '0' },
                                   billing: valid_params, shipping: valid_params }
            expect(response).to redirect_to('/checkouts/delivery')
          end
        end

        context 'with use billing' do
          it 'saves only billing address' do
            expect {
              put :update, params: { id: :address, use_billing: { 'true': '1' },
                                     shipping: invalid_params, billing: valid_params }
            }.to change(Address, :count).by(1)
          end

          it 'redirects to delivery step' do
            put :update, params: { id: :address, use_billing: { 'true': '1' },
                                   billing: valid_params, shipping: valid_params }
            expect(response).to redirect_to('/checkouts/delivery')
          end
        end
      end

      context 'invalid params' do
        it 'does not save addresses' do
          expect {
            put :update, params: { id: :address, use_billing: { 'true': '0' },
                                   billing: invalid_params, shipping: invalid_params }
          }.not_to change(Address, :count)
        end

        it 'renders address template' do
          put :update, params: { id: :address, use_billing: { 'true': '0' },
                                 billing: invalid_params, shipping: invalid_params }
          expect(response).to render_template(:address)
        end
      end
    end
  end
end
