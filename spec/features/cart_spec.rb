require 'rails_helper'

RSpec.feature 'Cart page', type: :feature do
  subject { page }

  context 'update cart' do
    let(:order) { FactoryBot.create(:order) }
    before do
      @order_item = FactoryBot.create(:order_item, order: order)
      visit '/users/sign_in'
      fill_in 'email', with: order.user.email
      fill_in 'password', with: 'qwerty123'
      click_button('Back to Store')
      visit '/cart'
    end

    scenario 'change order item quantity', js: true do
      expect(find("#quantity_input_#{@order_item.id}").value).to eq('1')
      find("#plus_#{@order_item.id}").click
      wait_for_ajax
      expect(find("#quantity_input_#{@order_item.id}").value).to eq('2')
      find("#minus_#{@order_item.id}").click
      wait_for_ajax
      expect(find("#quantity_input_#{@order_item.id}").value).to eq('1')
    end

    scenario 'can not decrease item quantity to less than 1', js: true do
      expect(find("#quantity_input_#{@order_item.id}").value).to eq('1')
      3.times do
        find("#minus_#{@order_item.id}").click
        wait_for_ajax
      end
      expect(find("#quantity_input_#{@order_item.id}").value).to eq('1')
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
