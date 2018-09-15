require 'rails_helper'

RSpec.feature 'Catalog Page', type: :feature do
  context 'links on book icons' do
    let(:shop_icon) { find('a.hidden-xs>span.shop-icon') }

    before do
      @book = create(:book)
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

  context 'filters' do
    let(:filter_menu) { find('ul.list-inline.pt-10.mb-25.mr-240') }

    before(:all) do
      @web_design = create(:category, title: 'Web design')
      @mobile_development = create(:category, title: 'Mobile development')
      @photo = create(:category, title: 'Photo')
      @web_books = create_list(:book, 4, category: @web_design)
      @mobile_books = create_list(:book, 4, category: @mobile_development)
      @photo_books = create_list(:book, 4, category: @photo)
    end

    before { visit('/catalog') }

    scenario 'show all books(by default)' do
      @mobile_books.each { |book| expect(page).to have_content(book.title) }
      @web_books.each { |book| expect(page).to have_content(book.title) }
      @photo_books.each { |book| expect(page).to have_content(book.title) }
    end

    scenario 'show Web design books' do
      filter_menu.click_on('Web design')
      @web_books.each { |book| expect(page).to have_content(book.title) }
      @photo_books.each { |book| expect(page).not_to have_content(book.title) }
      @mobile_books.each { |book| expect(page).not_to have_content(book.title) }
    end

    scenario 'show Mobile development books' do
      filter_menu.click_on('Mobile development')
      @web_books.each { |book| expect(page).not_to have_content(book.title) }
      @photo_books.each { |book| expect(page).not_to have_content(book.title) }
      @mobile_books.each { |book| expect(page).to have_content(book.title) }
    end

    scenario 'filter newest first' do
      filter_menu.click_on('Web design')
      click_link('Newest first', match: :first)
      @web_books.each { |book| expect(page).to have_content(book.title) }
      @photo_books.each { |book| expect(page).not_to have_content(book.title) }
      @mobile_books.each { |book| expect(page).not_to have_content(book.title) }
    end

    scenario 'filter popular first' do
      filter_menu.click_on('Mobile development')
      click_link('Popular first', match: :first)
      @web_books.each { |book| expect(page).not_to have_content(book.title) }
      @photo_books.each { |book| expect(page).not_to have_content(book.title) }
      @mobile_books.each { |book| expect(page).to have_content(book.title) }
    end
  end
end
