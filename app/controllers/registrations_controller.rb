class RegistrationsController < Devise::RegistrationsController
  include OrderTransfer

  def create
    super
    return unless @user.save
    transfer_order_to_user
    RegistrationMailer.with(email: @user.email, password: @user.password).registration_email.deliver_later
    flash[:notice] = I18n.t('notice.reg_message') + @user.email
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

  def email_params
    params.permit(:email)
  end
end
