require 'rails_helper'

RSpec.feature 'Cart page', type: :feature do
  context 'content' do
    before { visit('/cart') }

    it { expect(page).to have_content 'Cart' }
    it { expect(page).to have_content 'Checkout' }
    it { expect(page).to have_content 'Order Summary' }
    it { expect(page).to have_content 'SubTotal:' }
    it { expect(page).to have_content 'Coupon:' }
    it { expect(page).to have_content 'Order Total:' }
    it { expect(page).to have_content 'Coupon' }
    it { expect(page).to have_content 'Quantity' }
  end

  context 'update cart' do
    before do
      @order_item = FactoryBot.create(:order_item)
      allow_any_instance_of(ApplicationController).to receive(:current_cart).and_return(@order_item.cart)
      visit('/cart')
    end

    scenario 'can delete order item', js: true do
      expect {
        find('.general-cart-close', match: :first).click
        wait_for_ajax
      }.to change(OrderItem, :count).from(1).to(0)
    end

    scenario 'redirect to book page when click book details' do
      click_link(@order_item.book.title, match: :first)
      expect(page.current_path).to eq book_path(@order_item.book)
    end
  end

  context 'Coupon' do
    let(:coupon) { FactoryBot.create(:coupon) }
    before { visit('/cart') }

    scenario 'apply valid coupon' do
      fill_in I18n.t('cart.coupon'), with: coupon.code
      click_on I18n.t('cart.apply_coupon')
      expect(page).to have_content('Coupon was successfully added')
      expect(page).to have_content(coupon.discount)
    end

    scenario 'show error when try to apply invalid coupon' do
      fill_in I18n.t('cart.coupon'), with: 'fake code'
      click_on I18n.t('cart.apply_coupon')
      expect(page).to have_content('Coupon is invalid')
    end
  end
end
