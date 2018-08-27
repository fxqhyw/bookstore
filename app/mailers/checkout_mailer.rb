class CheckoutMailer < ApplicationMailer
  default from: 'noreply@amazingbookstore.com'

  def complete_email
    @user = params[:user]
    @order = params[:order]
    mail(to: @user.email, subject: 'Thank You for your Order!')
  end
end
