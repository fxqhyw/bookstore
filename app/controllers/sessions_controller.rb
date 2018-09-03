class SessionsController < Devise::SessionsController
  include OrderTransfer

  def create
    super
    transfer_order_to_user if params[:user][:from_checkout]
  end

  protected

  def after_sign_in_path_for(resource)
    if params[:user][:from_checkout]
      checkouts_path
    else
      root_path
    end
  end
end
