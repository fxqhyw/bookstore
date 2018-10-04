require "rails_helper"

RSpec.describe CheckoutMailer, type: :mailer do
  let(:order) { build(:order_with_delivery) }

  describe 'notify' do
    let(:mail) { CheckoutMailer.with(user: order.user, order: order).complete_email }

    it 'renders the headers' do
      expect(mail.subject).to eq('Thank You for your Order!')
      expect(mail.to).to eq([order.user.email])
      expect(mail.from).to eq(['noreply@amazingbookstore.com'])
    end
  end
end
