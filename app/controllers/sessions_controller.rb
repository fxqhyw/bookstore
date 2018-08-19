class SessionsController < Devise::SessionsController
  after_action :transfer_order_to_user, only: [:create]

  private

  def transfer_order_to_user
    if params[:user][:transfer_order]
      @user.orders.in_progress.destroy_all
      @user.orders << Order.find_by_id(cookies.encrypted[:order_id])
      @user.save
      cookies.delete :order_id
    end
  end
end
