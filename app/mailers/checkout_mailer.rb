class CheckoutMailer < ApplicationMailer
  def complete_email
    @user = params[:user]
    @order = params[:order]
    mail(to: @user.email, subject: 'Thank You for your Order!')
  end
end
