class RegistrationMailer < ApplicationMailer
  default from: 'noreply@amazingbookstore.com'

  def registration_email
    @email = params[:email]
    @password = params[:password]
    mail(to: @email, subject: 'Welcome to our Amazing Bookstore!')
  end
end
