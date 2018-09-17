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
    before do
      @web_books = create_list(:book, 3, category: create(:category, title: 'Web design'))
      @mobile_books = create_list(:book, 3, category: create(:category, title: 'Mobile development'))
      @photo_books = create_list(:book, 4, category: create(:category, title: 'Photo'))
      visit('/catalog')
    end

    scenario 'show all books(by default)' do
      @mobile_books.each { |book| expect(page).to have_content(book.title) }
      @web_books.each { |book| expect(page).to have_content(book.title) }
      @photo_books.each { |book| expect(page).to have_content(book.title) }
    end

    scenario 'show Web design books' do
      click_link('Web design', match: :first)
      @web_books.each { |book| expect(page).to have_content(book.title) }
      @photo_books.each { |book| expect(page).not_to have_content(book.title) }
      @mobile_books.each { |book| expect(page).not_to have_content(book.title) }
    end

    scenario 'show Mobile development books' do
      click_link('Mobile development', match: :first)
      @web_books.each { |book| expect(page).not_to have_content(book.title) }
      @photo_books.each { |book| expect(page).not_to have_content(book.title) }
      @mobile_books.each { |book| expect(page).to have_content(book.title) }
    end

    scenario 'filter newest first' do
      click_link('Web design', match: :first)
      click_link('Newest first', match: :first)
      @web_books.each { |book| expect(page).to have_content(book.title) }
      @photo_books.each { |book| expect(page).not_to have_content(book.title) }
      @mobile_books.each { |book| expect(page).not_to have_content(book.title) }
    end

    scenario 'filter popular first' do
      click_link('Mobile development', match: :first)
      click_link('Popular first', match: :first)
      @web_books.each { |book| expect(page).not_to have_content(book.title) }
      @photo_books.each { |book| expect(page).not_to have_content(book.title) }
      @mobile_books.each { |book| expect(page).to have_content(book.title) }
    end
  end
end
