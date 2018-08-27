require 'rails_helper'

RSpec.feature 'Orders Page', type: :feature do
  before do
    @user = FactoryBot.create(:user)
    @order_in_queue = FactoryBot.create(:order_with_delivery, :in_queue, user: @user)
    @order_item_in_queue = FactoryBot.create(:order_item, order: @order_in_queue)
    FactoryBot.create(:address, order: @order_in_queue)
    FactoryBot.create(:credit_card, order: @order_in_queue)
    @order_in_delivery = FactoryBot.create(:order_with_delivery, :in_delivery, user: @user)
    FactoryBot.create(:order_item, order: @order_in_delivery)
    @order_delivered = FactoryBot.create(:order_with_delivery, :delivered, user: @user)
    FactoryBot.create(:order_item, order: @order_delivered)
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

  scenario 'filter delivered orders' do
    click_link('Delivered')
    expect(page).to have_content(@order_delivered.number)
    expect(page).to have_content(@order_delivered.total_price)
    expect(page).not_to have_content(@order_in_queue.number)
    expect(page).not_to have_content(@order_in_queue.total_price)
    expect(page).not_to have_content(@order_in_delivery.number)
    expect(page).not_to have_content(@order_in_delivery.total_price)
  end

  scenario 'go to the order info page' do
    click_link(@order_in_queue.number, match: :first)
    expect(page).to have_content(@order_in_queue.number)
    expect(page).to have_content(@order_in_queue.billing_address.first_name)
    expect(page).to have_content(@order_in_queue.billing_address.last_name)
    expect(page).to have_content(@order_in_queue.billing_address.address)
    expect(page).to have_content(@order_in_queue.billing_address.city)
    expect(page).to have_content(@order_in_queue.billing_address.country)
    expect(page).to have_content(@order_in_queue.billing_address.phone)
    expect(page).to have_content(@order_in_queue.credit_card.expiration_date)
    expect(page).to have_content(@order_in_queue.delivery.name)
    expect(page).to have_content(@order_in_queue.delivery.duration)
    expect(page).to have_content(@order_item_in_queue.book.title)
    expect(page).to have_content(@order_item_in_queue.quantity)
  end
end
