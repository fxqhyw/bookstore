require 'rails_helper'

RSpec.describe BooksController, type: :controller do
  describe 'GET #index' do
    before { get :index, params: { category: '1', filter: 'newest'} }

    it 'renders :index remplate' do
      expect(response).to render_template(:index)
    end

    it 'assigns @books' do
      expect(assigns(:books)).not_to be_nil
    end

    it 'assigns @category_id' do
      expect(assigns(:category_id)).to eq('1')
    end

    it 'assigns @filter' do
      expect(assigns(:filter)).to eq('newest')
    end
  end

  describe 'GET #show' do
    let(:book) { create(:book) }
    before { get :show, params: { id: book.id } }

    it 'renders :show template' do
      expect(response).to render_template(:show)
    end

    it 'assigns requested book to @book' do
      expect(assigns(:book)).to eq(book)
    end
  end
end
