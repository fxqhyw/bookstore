require 'rails_helper'

RSpec.feature 'Home Page', type: :feature do
  subject { page }

  scenario 'click on Get Started link' do
    visit('/')
    click_link('Get Started')
    expect(page).to have_current_path('/catalog')
  end

  context 'add books to cart' do
    let(:shop_icon) { page.find('a.hidden-xs>span.shop-icon') }

    before do
      @book = FactoryBot.create(:book)
      FactoryBot.create(:order_item, book: @book)
      visit('/')
    end

    scenario 'can add latest book to cart', js: true do
      click_link('Buy Now')
      expect(shop_icon).to have_content('1')
    end

    scenario 'can add bestsellers book to cart', js: true do
      first('i.fa.fa-shopping-cart.thumb-icon').click
      expect(shop_icon).to have_content('1')
    end
  end
end
