require 'rails_helper'

RSpec.describe ReviewsController, type: :controller do
  describe 'POST #create' do
    let(:user) { create(:user) }
    let(:book) { create(:book) }
    let(:review_params) { { title: 'title', description: 'some description', rating: 5, user_id: user.id, book_id: book.id } }

    before { sign_in(user) }
    context 'valid params' do
      it 'creates a new review' do
        expect {
          post :create, params: { review: review_params }
        }.to change(Review, :count).by(1)
      end

      it 'redirects to the book page' do
        post :create, params: { review: review_params }
        expect(response).to redirect_to(book)
      end

      it 'shows thanks notice message' do
        post :create, params: { review: review_params }
        expect(flash[:notice]).to eq(I18n.t('review.thanks_message'))
      end
    end

    context 'invalid params' do
      before { post :create, params: { review: { user_id: user.id, book_id: book.id } } }

      it 'redirects to the book page' do
        expect(response).to redirect_to(book)
      end

      it 'shows alert message incorrect' do
        expect(flash[:alert]).to eq(I18n.t('review.incorrect'))
      end
    end
  end
end
