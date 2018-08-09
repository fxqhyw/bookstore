require 'rails_helper'

RSpec.feature 'Catalog Page', type: :feature do
  subject { page }

  context 'links on book icons' do
    before(:all) { @book = FactoryBot.create(:book) }
    before(:each) { visit('/catalog') }
    let(:shop_icon) { find('a.hidden-xs>span.shop-icon') }

    scenario 'can add book to cart', js: true do
      first('i.fa.fa-shopping-cart.thumb-icon').click
      expect(shop_icon).to have_content('1')
    end

    scenario 'click on show book link' do
      find(:linkhref, book_path(@book)).click
      expect(page).to have_http_status(:success)
      expect(page).to have_current_path("/books/#{@book.id}")
    end
  end

  context 'filters by category' do
    let(:filter_menu) { find('ul.list-inline.pt-10.mb-25.mr-240') }

    before(:all) do
      FactoryBot.create(:category, title: 'Web design')
      FactoryBot.create(:category, title: 'Mobile development')
      @web_design = Category.find_by_title('Web design')
      @mobile_development = Category.find_by_title('Mobile development')
      FactoryBot.create_list(:book, 8, category: @web_design)
      FactoryBot.create_list(:book, 4, category: @mobile_development)
    end

    before { visit('/catalog') }

    scenario 'show all books(by default)' do
      expect(page).to have_selector('div.col-xs-6.col-sm-3', count: 12)
    end

    scenario 'show Web design books' do
      filter_menu.find(:filter_by_category, @web_design.id).click
      expect(page).to have_selector('div.col-xs-6.col-sm-3', count: 8)
    end

    scenario 'show Mobile development books' do
      filter_menu.find(:filter_by_category, @mobile_development.id).click
      expect(page).to have_selector('div.col-xs-6.col-sm-3', count: 4)
    end
  end

  context 'sorts' do
    before { visit('/catalog') }

    it { expect(page).to have_content 'Catalog' }
    it { expect(page).to have_content 'Title A - Z' }
    it { expect(page).to have_content 'Title Z - A' }
    it { expect(page).to have_content 'Price: Low to hight' }
    it { expect(page).to have_content 'Price: Hight to low' }
    it { expect(page).to have_content 'Newest first' }
    it { expect(page).to have_content 'Newest first' }
  end
end
