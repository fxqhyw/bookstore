require 'rails_helper'

RSpec.describe BooksController, type: :controller do
  describe 'GET #index' do
    before { get :index }

    it 'renders :index remplate' do
      expect(response).to render_template(:index)
    end

    it 'assigns @books' do
      expect(assigns(:books)).not_to be_nil
    end

    it 'assigns @categories' do
      expect(assigns(:books)).not_to be_nil
    end
  end

  describe 'GET #show' do
    let(:book) { FactoryBot.create(:book) }
    before { get :show, params: { id: book.id } }

    it 'renders :show template' do
      expect(response).to render_template(:show)
    end

    it 'assigns requested book to @book' do
      expect(assigns(:book)).to eq(book)
    end
  end
end
