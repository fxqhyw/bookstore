require 'rails_helper'

RSpec.feature 'Home Page', type: :feature do
  subject { page }

  context 'content' do
    before { visit('/') }
    it { expect(page.find('#slider')).not_to be_nil }
    it { expect(page).to have_content('Get Started') }
    it { expect(page).to have_content('Best Sellers') }
  end

  scenario 'click on Get Started link' do
    visit('/')
    click_link('Get Started')
    expect(page).to have_current_path('/catalog')
  end

  context 'add books to cart' do
    let(:shop_icon) { page.find('a.hidden-xs>span.shop-icon') }

    before do
      FactoryBot.create_list(:book, 4)
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
