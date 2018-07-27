require 'rails_helper'

RSpec.feature 'HomePage', type: :feature do
  context 'content' do
    before { visit('/') }

    scenario 'Can see Latest Books' do
      expect(find('#slider')).not_to be_nil
    end

    scenario 'Can see Get Started' do
      expect(page).to have_content('Get Started')
    end

    scenario 'Can see Best Sellers' do
      expect(page).to have_content('Best Sellers')
    end

    scenario 'Click on Get Started link' do
      click_link('Get Started')
      expect(page).to have_current_path('/catalog')
    end
  end

  context 'add books to cart' do
    before do
      @book = FactoryBot.create(:book)
      visit('/')
    end

    scenario 'Can buy latest book', js: true do
      click_link('Buy Now')
      expect(page.find('a.hidden-xs>span.shop-icon')).to have_content('1')
    end

    scenario 'Can buy bestsellers book', js: true do
      find('i.fa.fa-shopping-cart.thumb-icon').click
      expect(page.find('a.hidden-xs>span.shop-icon')).to have_content('1')
    end
  end
end
