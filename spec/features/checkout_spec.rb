require 'rails_helper'

RSpec.feature 'Checkout', type: :feature do
  let(:user) { FactoryBot.create(:user) }

  scenario 'try to go to checkout path with empty cart' do
    visit('/checkouts')
    expect(page).to have_current_path('/cart')
    expect(page).to have_content('Cart is empty')
  end

  describe 'login step' do
    before do
      @order_item = FactoryBot.create(:order_item)
      my_jar = ActionDispatch::Request.new(Rails.application.env_config).cookie_jar
      my_jar.signed[:order_id] = @order_item.order_id
      create_cookie(:order_id, my_jar[:order_id])
      visit('/checkouts')
    end

    scenario 'login step with quick register' do
      expect(page).to have_current_path('/checkouts/login')
      within '#quick_register_form' do
        fill_in 'Enter Email', with: 'myemail@gmail.com'
        click_button('Continue to Checkout')
      end
      expect(page).to have_current_path('/checkouts/address')
      expect(page).to have_content('You have successfully registered, your account information has been sent to myemail@gmail.com')
    end

    scenario 'login with password' do
      expect(page).to have_current_path('/checkouts/login')
      within '#login_form' do
        fill_in 'Enter Email', with: user.email
        fill_in 'Password', with: 'qwerty123'
        click_button('Log in with password')
      end
      expect(page).to have_current_path('/checkouts/address')
      expect(page).to have_content('Signed in successfully.')
    end

    scenario 'try to login with invalid data' do
      expect(page).to have_current_path('/checkouts/login')
      within '#login_form' do
        fill_in 'Enter Email', with: 'random@email.com'
        fill_in 'Password', with: '123123'
        click_button('Log in with password')
      end
      expect(page).not_to have_content('Signed in successfully.')
      expect(page).to have_content('Invalid Email or password.')
    end
  end

  describe 'other steps' do
    let(:address) { FactoryBot.create(:address) }

    before do
      FactoryBot.create_list(:delivery, 3)
      @book = FactoryBot.create(:book)
      visit '/users/sign_in'
      fill_in 'email', with: address.user.email
      fill_in 'password', with: 'qwerty123'
      click_button('Back to Store')
      visit('/catalog')
      find("#book#{@book.id}_cart_icon").click
      wait_for_ajax
      visit '/checkouts'
    end

    scenario 'pass all steps from address to complete', js: true do
      expect(page).to have_current_path('/checkouts/address')
      expect(page).to have_field('First Name', with: address.first_name)
      expect(page).to have_field('Last Name', with: address.last_name)
      expect(page).to have_field('Address', with: address.address)
      expect(page).to have_field('City', with: address.city)
      expect(page).to have_field('Zip', with: address.zip)
      expect(page).to have_field('Phone', with: address.phone)
      find('.checkbox-icon').click
      click_button('Save and Continue')
      expect(page).to have_current_path('/checkouts/delivery')
      find('.radio-icon', match: :first).click
      click_button('Save and Continue')
      expect(page).to have_current_path('/checkouts/payment')
      fill_in 'Card Number', with: '12345678912312'
      fill_in 'Name on Card', with: 'Loker Lucker'
      fill_in 'MM / YY', with: '11/22'
      fill_in 'CVV', with: '123'
      click_button('Save and Continue')
      expect(page).to have_current_path('/checkouts/confirm')
      find('#edit_address_link').click
      expect(page).to have_current_path('/checkouts/address?edit=true')
      expect(page).to have_field('Zip', with: address.zip)
      within '#billing' do
        fill_in 'Zip', with: '321'
      end
      find('.checkbox-icon').click
      click_button('Save and Continue')
      expect(page).to have_current_path('/checkouts/confirm')
      click_on('Place Order')
      expect(page).to have_content('Thank You for your Order!')
      click_on('Back to Store')
      expect(page).to have_current_path('/catalog')
    end
  end
end
