require 'rails_helper'

RSpec.feature 'Catalog Page', type: :feature do
  before do
    @category1 = FactoryBot.create(:category)
    @category2 = FactoryBot.create(:category)
    @book = FactoryBot.create(:book, category: @category1)
  end

  let(:shop_icon) { page.find('a.hidden-xs>span.shop-icon') }

  scenario 'can add book to cart', js: true do
    visit('/catalog')
    first('i.fa.fa-shopping-cart.thumb-icon').click
    expect(shop_icon).to have_content('1')
  end

  scenario 'click on show book link' do
    visit('/catalog')
    find(:linkhref, book_path(@book)).click
    expect(page).to have_current_path("/books/#{@book.id}")
  end
end