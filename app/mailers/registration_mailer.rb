class RegistrationMailer < ApplicationMailer
  default from: 'noreply@amazingbookstore.com'

  def registration_email
    @user = params[:user]
    #@password = params[:password]
    mail(to: @user.email, subject: 'Welcome to our Amazing Bookstore!')
  end
end
