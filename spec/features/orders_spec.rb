require 'rails_helper'

RSpec.feature 'Orders Page', type: :feature do
  before do
    @user = FactoryBot.create(:user)
    @order_in_queue = FactoryBot.create(:order, :in_queue, user: @user)
    @order_item_in_queue = FactoryBot.create(:order_item, order: @order_in_queue)
    @order_in_delivery = FactoryBot.create(:order, :in_delivery, user: @user)
    @order_item_in_delivery = FactoryBot.create(:order_item, order: @order_in_delivery)
    @order_delivered = FactoryBot.create(:order, :delivered, user: @user)
    @order_item_delivered = FactoryBot.create(:order_item, order: @order_delivered)
    visit '/users/sign_in'
    fill_in 'email', with: @user.email
    fill_in 'password', with: 'qwerty123'
    click_button('Back to Store')
    visit('/orders')
  end

  scenario 'show all orders' do
    expect(page).to have_content('All')
    [@order_in_queue, @order_in_delivery, @order_delivered].each do |order|
      expect(page).to have_content(order.number)
      expect(page).to have_content(order.total_price)
    end
  end

  scenario 'filter in_queue orders' do
    click_link('Waiting for processing')
    expect(page).to have_content(@order_in_queue.number)
    expect(page).to have_content(@order_in_queue.total_price)
    expect(page).not_to have_content(@order_in_delivery.number)
    expect(page).not_to have_content(@order_in_delivery.total_price)
    expect(page).not_to have_content(@order_delivered.number)
    expect(page).not_to have_content(@order_delivered.total_price)
  end

  scenario 'filter in_delivery orders' do
    click_link('In delivery')
    expect(page).to have_content(@order_in_delivery.number)
    expect(page).to have_content(@order_in_delivery.total_price)
    expect(page).not_to have_content(@order_in_queue.number)
    expect(page).not_to have_content(@order_in_queue.total_price)
    expect(page).not_to have_content(@order_delivered.number)
    expect(page).not_to have_content(@order_delivered.total_price)
  end

  scenario 'filter in_delivery orders' do
    click_link('Delivered')
    expect(page).to have_content(@order_delivered.number)
    expect(page).to have_content(@order_delivered.total_price)
    expect(page).not_to have_content(@order_in_queue.number)
    expect(page).not_to have_content(@order_in_queue.total_price)
    expect(page).not_to have_content(@order_in_delivery.number)
    expect(page).not_to have_content(@order_in_delivery.total_price)
  end
end
