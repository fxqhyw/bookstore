require 'rails_helper'

RSpec.feature 'Cart page', type: :feature do
  before do
    @book = create(:book)
    visit('/catalog')
    find("#book#{@book.id}_cart_icon").click
    wait_for_ajax
    visit('/cart')
  end

  context 'update cart', js: true do
    let(:quantity_input) { find("#quantity_input_#{@book.id}") }
    let(:shop_icon) { find('a.hidden-xs>span.shop-icon') }
    let(:plus) { find("#plus_#{@book.id}") }
    let(:minus) { find("#minus_#{@book.id}") }

    scenario 'change order item quantity' do
      expect(quantity_input).to have_content('1')
      expect(shop_icon).to have_content('1')
      plus.click
      wait_for_ajax
      expect(shop_icon).to have_content('2')
      expect(quantity_input).to have_content('2')
      minus.click
      wait_for_ajax
      expect(shop_icon).to have_content('1')
      expect(quantity_input).to have_content('1')
    end

    scenario 'can not decrease item quantity to less than 1'do
      expect(shop_icon).to have_content('1')
      expect(quantity_input).to have_content('1')
      3.times do
        minus.click
        wait_for_ajax
      end
      expect(shop_icon).to have_content('1')
      expect(quantity_input).to have_content('1')
    end

    scenario 'redirect to book page when click book details' do
      click_link(@book.title)
      expect(page).to have_current_path book_path(@book)
    end

    scenario 'delete order item' do
      expect {
        find('.general-cart-close', match: :first).click
        wait_for_ajax
      }.to change(OrderItem, :count).from(1).to(0)
    end
  end

  context 'Coupon', js: true do
    let(:coupon) { create(:coupon) }

    scenario 'apply valid coupon' do
      fill_in I18n.t('cart.coupon'), with: coupon.code
      click_button I18n.t('cart.apply_coupon')
      expect(page).to have_content I18n.t('notice.coupon_added')
      expect(page).to have_content(coupon.discount)
    end

    scenario 'show error when try to apply invalid coupon' do
      fill_in I18n.t('cart.coupon'), with: 'fake code'
      click_button I18n.t('cart.apply_coupon')
      expect(page).to have_content I18n.t('notice.coupon_invalid')
    end
  end
end
