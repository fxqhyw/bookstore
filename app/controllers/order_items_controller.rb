class OrderItemsController < ApplicationController
  before_action :order_item, only: %i[update destroy]

  def create
    CreateOrderItem.call(order: current_order, user: current_user, params: permited_params) do
      on(:ok) { render :create }
    end
  end

  def update
    @order_item.update(quantity: params[:quantity])
  end

  def destroy
    @order_item.destroy
  end

  private

  def create_order
    if user_signed_in?
      current_user.orders.create
    else
      order = Order.create
      cookies.signed[:order_id] = { value: order.id, expires: 1.month.from_now }
    end
  end

  def permited_params
    params.permit(:quantity, :book_id)
  end

  def order_item
    @order_item = OrderItem.find(params[:id])
  end
end
