require 'rails_helper'

RSpec.describe OrderItemsController, type: :controller do
  let(:book) { FactoryBot.create(:book) }
  let(:order_item) { FactoryBot.create(:order_item, book: book, quantity: 1) }

  describe 'POST #create' do
    context 'order item already exist' do
      it 'increases order item quantity' do
        post :create, xhr: true, params: { book_id: order_item.book_id, quantity: 1 }
        order_item.reload
        expect(order_item.quantity).to eq(2)
      end
    end

    context 'order item does not yet exist' do
      let(:cart) { FactoryBot.create(:cart) }
      it 'creates new order item in the database' do
        expect {
          post :create, xhr: true, params: { book_id: book.id, quantity: 1, cart_id: cart.id }
        }.to change(OrderItem, :count).by(1)
      end
    end
  end

  describe 'PUT #update' do
    it 'changes order item quantity' do
      put :update, xhr: true, params: { id: order_item.id, quantity: 3 }
      order_item.reload
      expect(order_item.quantity).to eq(3)
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes order item from the database' do
      delete :destroy, xhr: true, params: { id: order_item.id }
      expect(OrderItem.exists?(order_item.id)).to be_falsy
    end
  end
end
