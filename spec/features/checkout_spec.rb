require 'rails_helper'

RSpec.feature 'Checkout', type: :feature do
  let(:address) { FactoryBot.create(:address) }

  scenario 'try to go to checkout path with empty cart' do
    visit('/checkouts')
    expect(page).to have_current_path('/cart')
    expect(page).to have_content('Cart is empty')
  end

  describe 'user is a guest', js: true do
    before do
      @book = FactoryBot.create(:book)
      visit('/catalog')
      find("#book#{@book.id}_cart_icon").click
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
  end

  describe 'user is logged in' do
    before do
      @book = FactoryBot.create(:book)
      visit('/catalog')
      find("#book#{@book.id}_cart_icon").click
      visit '/users/sign_in'
      fill_in 'email', with: address.user.email
      fill_in 'password', with: 'qwerty123'
      click_button('Back to Store')
      visit('/checkouts')
    end
  end

  describe 'address step' do
  end
end
