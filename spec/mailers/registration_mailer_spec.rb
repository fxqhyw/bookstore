require "rails_helper"

RSpec.describe RegistrationMailer, type: :mailer do
  describe 'notify' do
    let(:mail) { RegistrationMailer.with(email: 'user@email.com').registration_email }

    it 'renders the headers' do
      expect(mail.subject).to eq('Welcome to our Amazing Bookstore!')
      expect(mail.to).to eq(['user@email.com'])
      expect(mail.from).to eq(['noreply@amazingbookstore.com'])
    end
  end
end
