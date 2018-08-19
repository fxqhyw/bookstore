class SessionsController < Devise::SessionsController
  after_action :transfer_order_to_user, only: [:create]

  protected

  def after_sign_in_path_for(resource)
    if params[:user][:from_checkout]
      checkouts_path
    else
      root_path
    end
  end

  private

  def transfer_order_to_user
    if params[:user][:from_checkout]
      @user.orders.in_progress.destroy_all
      @user.orders << Order.find_by_id(cookies.encrypted[:order_id])
      @user.save
      cookies.delete :order_id
    end
  end
end
