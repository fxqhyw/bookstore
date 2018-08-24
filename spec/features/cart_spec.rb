require 'rails_helper'

RSpec.feature 'Cart page', type: :feature do
  subject { page }

  context 'update cart' do
    let(:quantity_input) { find("#quantity_input_#{@order_item.id}") }
    let(:shop_icon) { find('a.hidden-xs>span.shop-icon') }
    let(:plus) { find("#plus_#{@order_item.id}", visible: true) }
    let(:minus) { find("#minus_#{@order_item.id}", visible: true) }

    before do
      @order_item = FactoryBot.create(:order_item)
      my_jar = ActionDispatch::Request.new(Rails.application.env_config).cookie_jar
      my_jar.signed[:order_id] = @order_item.order_id
      create_cookie(:order_id, my_jar[:order_id])
      visit '/cart'
    end

    scenario 'change order item quantity', js: true do
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

    scenario 'can not decrease item quantity to less than 1', js: true do
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
      click_link(@order_item.book.title, match: :first)
      expect(page).to have_current_path book_path(@order_item.book)
    end

    scenario 'delete order item', js: true do
      expect {
        find('.general-cart-close', match: :first).click
        wait_for_ajax
      }.to change(OrderItem, :count).from(1).to(0)
    end
  end

  context 'Coupon' do
    let(:coupon) { FactoryBot.create(:coupon) }
    before { visit('/cart') }

    scenario 'apply valid coupon' do
      fill_in I18n.t('cart.coupon'), with: coupon.code
      click_button I18n.t('cart.apply_coupon')
      expect(page).to have_content('Coupon was successfully added')
      expect(page).to have_content(coupon.discount)
    end

    scenario 'show error when try to apply invalid coupon' do
      fill_in I18n.t('cart.coupon'), with: 'fake code'
      click_button I18n.t('cart.apply_coupon')
      expect(page).to have_content('Coupon is invalid')
    end
  end
end
