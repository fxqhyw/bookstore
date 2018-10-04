require 'rails_helper'

RSpec.feature 'Book page', type: :feature do
  subject { page }
  before(:all) { @book = create(:book) }

  scenario 'show book content' do
    visit book_path(@book)
    expect(page).to have_content @book.title
    expect(page).to have_content @book.materials
    expect(page).to have_content @book.published_at
  end

  context 'short description' do
    scenario "'Read More' button absent", js: true do
      @book.description = 'short description '
      @book.save!
      visit book_path(@book)
      expect(page).not_to have_content('Read More')
    end
  end

  context 'long description' do
    scenario "'Read More' button present", js: true do
      @book.description = 'description ' * 50
      @book.save!
      visit book_path(@book)
      expect(page).to have_content('Read More')
    end
  end

  context 'Add to Cart' do
    let(:shop_icon) { find('a.hidden-xs>span.shop-icon') }
    let(:plus) { find('a.input-link.quantity-plus') }
    let(:minus) { find('a.input-link.quantity-minus') }
    let(:qtty_input) { find('#order_item_quantity') }

    before { visit book_path(@book) }

    scenario 'add one item into cart', js: true do
      click_button I18n.t('button.add_to_cart')
      wait_for_ajax
      expect(shop_icon).to have_content('1')
    end

    scenario 'increase quantity counter', js: true do
      plus.trigger('click')
      expect(qtty_input.value).to eq('2')
    end

    scenario 'can not decrease counter less than 1', js: true do
      3.times { minus.trigger('click') }
      expect(qtty_input.value).to eq('1')
    end

    scenario 'add four items into cart', js: true do
      fill_in 'order_item_quantity', with: '4'
      click_button I18n.t('button.add_to_cart')
      wait_for_ajax
      expect(shop_icon).to have_content('4')
    end
  end
end
