require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  describe 'GET #index' do
    before { get :index }

    it 'renders :index remplate' do
      expect(response).to render_template(:index)
    end

    it 'assigns latest books to the template' do
      expect(assigns(:latest_books)).not_to be_nil
    end

    it 'assigns best sellers book to the template' do
      expect(assigns(:best_sellers)).not_to be_nil
    end
  end
end
