class RegistrationsController < Devise::RegistrationsController
  after_action :transfer_order_to_user, only: [:create]

  def create
    super
    RegistrationMailer.with(email: @user.email, password: @user.password).registration_email.deliver_later
    flash[:notice] = "You have successfully registered, your account information has been sent to #{@user.email}"
  end

  protected

  def update_resource(resource, params)
    return super if params.include?(:current_password)
    resource.update_without_password(email_params)
  end

  def after_sign_up_path_for(resource)
    if params[:user][:from_checkout]
      checkouts_path
    else
      root_path
    end
  end

  private

  def transfer_order_to_user
    @current_order.update(user_id: @user.id)
    cookies.delete :order_id
  end

  def email_params
    params.permit(:email)
  end
end
