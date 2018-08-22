require 'rails_helper'

RSpec.feature 'Settings Page', type: :feature do
  let(:address) { FactoryBot.create(:address) }

  before do
    visit '/users/sign_in'
    fill_in 'email', with: address.user.email
    fill_in 'password', with: 'qwerty123'
    click_on 'Back to Store'
  end

  describe 'address tab' do
    before { visit '/settings/address' }

    scenario 'show user address paramentrs' do
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
      expect(page).to have_css('div.has-error')
      expect(page).not_to have_content('Updated!')
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
  end
end
