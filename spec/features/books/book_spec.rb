require 'rails_helper'

RSpec.feature 'Book page', type: :feature do
  before(:all) { @book = FactoryBot.create(:book) }

  describe 'content' do
    before { visit book_path(@book) }
    it { expect(page).to have_content 'Back to results' }
    it { expect(page).to have_content 'Year of publication' }
    it { expect(page).to have_content 'Dimensions' }
    it { expect(page).to have_content @book.title }
    it { expect(page).to have_content @book.materials }
    it { expect(page).to have_content @book.published_at }
  end

  context 'short description' do
    it "'Read More' button absent", js: true do
      @book.description = 'short description '
      @book.save!
      visit book_path(@book)
      expect(page).not_to have_content('Read More')
    end
  end

  context 'long description' do
    it "'Read More' button present", js: true do
      @book.description = 'long description ' * 100
      @book.save!
      visit book_path(@book)
      expect(page).to have_content('Read More')
    end
  end

  describe 'Add to Cart' do
    let(:shop_icon) { page.find('a.hidden-xs>span.shop-icon') }
    let(:plus) { find('i.fa.fa-plus.line-height-40') }
    let(:minus) { find('i.fa.fa-minus.line-height-40') }

    before { visit book_path(@book) }

    it 'add one item into cart', js: true do
      click_on I18n.t('button.add_to_cart')
      expect(shop_icon).to have_content('1')
    end

    it 'inreases quantity counter', js: true do
      plus.trigger('click')
      expect(page.find('#order_item_quantity').value).to eq('2')
    end

    it 'not deasreses counter less then 1', js: true do
      minus.trigger('click')
      expect(page.find('#order_item_quantity').value).to eq('1')
    end

    it 'add four items into cart', js: true do
      fill_in 'order_item[quantity]', with: '4'
      click_on I18n.t('button.add_to_cart')
      expect(shop_icon).to have_content('4')
    end
  end
end
