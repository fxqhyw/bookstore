class OrderItemsController < ApplicationController
  def create
    @order_item = OrderItem.create(order_item_params)
  end

  private

  def order_item_params
    params.require(:order_item).permit(:quantity, :book_id, :cart_id)
  end
end
