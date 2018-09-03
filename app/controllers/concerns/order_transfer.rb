module OrderTransfer
  extend ActiveSupport::Concern

  included do
    private

    def transfer_order_to_user
      order = Order.find_by_id(cookies.signed[:order_id])
      return unless order
      @user.orders.in_progress.destroy_all
      @user.orders << order
      @user.save
      cookies.delete :order_id
    end
  end
end
