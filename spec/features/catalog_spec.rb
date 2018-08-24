require 'rails_helper'

RSpec.feature 'Catalog Page', type: :feature do
  subject { page }

  context 'links on book icons' do
    let(:shop_icon) { find('a.hidden-xs>span.shop-icon') }

    before do
      @book = FactoryBot.create(:book)
      visit('/catalog')
    end

    scenario 'can add book to cart', js: true do
      find("#book#{@book.id}_cart_icon").click
      expect(shop_icon).to have_content('1')
    end

    scenario 'click on show book link' do
      find("#book#{@book.id}_link").click
      expect(page).to have_current_path("/books/#{@book.id}")
    end
  end

  context 'filters by category' do
    let(:filter_menu) { find('ul.list-inline.pt-10.mb-25.mr-240') }
    let(:book_div) { 'div.col-xs-6.col-sm-3' }

    before(:all) do
      @web_design = FactoryBot.create(:category, title: 'Web design')
      @mobile_development = FactoryBot.create(:category, title: 'Mobile development')
      FactoryBot.create_list(:book, 8, category: @web_design)
      FactoryBot.create_list(:book, 4, category: @mobile_development)
    end

    before { visit('/catalog') }

    scenario 'show all books(by default)' do
      expect(page).to have_selector(book_div, count: 12)
    end

    scenario 'show Web design books' do
      filter_menu.click_on('Web design').click
      expect(page).to have_selector(book_div, count: 8)
    end

    scenario 'show Mobile development books' do
      filter_menu.click_on('Mobile development')
      expect(page).to have_selector(book_div, count: 4)
    end
  end
end