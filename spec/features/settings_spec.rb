require 'rails_helper'

RSpec.feature 'Settings Page', type: :feature do
  let(:address) { create(:address) }

  before { login_as(address.user, scope: :user) }

  describe 'address tab' do
    before { visit '/settings/address' }

    scenario 'show user address parametrs' do
      expect(page).to have_field('First Name', with: address.first_name)
      expect(page).to have_field('Last Name', with: address.last_name)
      expect(page).to have_field('Address', with: address.address)
      expect(page).to have_field('City', with: address.city)
      expect(page).to have_field('Zip', with: address.zip)
      expect(page).to have_field('Phone', with: address.phone)
    end

    scenario 'update fields with valid values' do
      within '#BillingAddress_form' do
        fill_in 'First Name', with: 'Loker'
        fill_in 'City', with: 'Jitomir city'
        fill_in 'Zip', with: '123'
        click_button('Save')
      end
      expect(page).to have_content('Updated!')
      expect(page).to have_field('First Name', with: 'Loker')
      expect(page).to have_field('City', with: 'Jitomir city')
      expect(page).to have_field('Zip', with: '123')
    end

    scenario 'try update fields with invalid values' do
      within '#BillingAddress_form' do
        fill_in 'First Name', with: '123'
        fill_in 'City', with: ''
        fill_in 'Zip', with: 'qqq'
        click_button('Save')
      end
      expect(page).not_to have_content('Updated!')
      expect(page).to have_css('div.has-error')
      expect(page).to have_content('must consist of only letters')
      expect(page).to have_content("can't be blank")
      expect(page).to have_content('must consist of only digits')
      expect(page).to have_field('First Name', with: '123')
      expect(page).to have_field('Zip', with: 'qqq')
      expect(page).to have_field('City', with: '')
    end
  end

  describe 'privacy tab' do
    before { visit '/settings/privacy' }

    scenario 'change user email with valid data' do
      within '#edit_email_form' do
        fill_in 'Enter Email', with: 'brandnew@email.com'
        click_button('Save')
      end
      expect(page).to have_current_path('/')
      expect(page).to have_content('Your account has been updated successfully.')
    end

    scenario 'try to change user email with invalid data' do
      within '#edit_email_form' do
        fill_in 'Enter Email', with: 'No'
        click_button('Save')
      end
      expect(page).to have_content('Email is invalid')
      expect(page).not_to have_content('Your account has been updated successfully.')
    end

    scenario 'try to change user password with invalid data' do
      within '#edit_password_form' do
        fill_in 'Old Password', with: 'qwerty'
        fill_in 'New Password', with: '123'
        fill_in 'Confirm Password', with: '123'
        click_button('Save')
      end
      expect(page).not_to have_content('Your account has been updated successfully.')
      expect(page).to have_content('Current password is invalid')
      expect(page).to have_content('Password is too short (minimum is 8 characters)')
    end

    scenario 'change user password with valid data' do
      within '#edit_password_form' do
        fill_in 'Old Password', with: 'qwerty123'
        fill_in 'New Password', with: '123qwerty'
        fill_in 'Confirm Password', with: '123qwerty'
        click_button('Save')
      end
      expect(page).to have_current_path('/')
      expect(page).to have_content('Your account has been updated successfully.')
    end

    scenario 'remove account', js: true do
      expect(page).to have_button('Please Remove My Account', disabled: true)
      find('.checkbox-text').trigger('click')
      expect(page).to have_button('Please Remove My Account', disabled: false)
      click_button('Please Remove My Account')
      expect(page).to have_content('Bye! Your account has been successfully cancelled. We hope to see you again soon.')
      expect(page).to have_current_path('/')
    end
  end
end
