class OrderItemsController < ApplicationController
  before_action :order_item, only: %i[update destroy]

  def create
    create_order unless @current_order
    @order_item = @current_order.order_items.find_by(book_id: params[:book_id])
    if @order_item
      @order_item.quantity += params[:quantity].to_i
      @order_item.save
    else
      @order_item = @current_order.order_items.create(permited_params)
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
      @current_order = current_user.orders.create
    else
      @current_order = Order.create
      cookies.signed[:order_id] = { value: @current_order.id, expires: 1.month.from_now }
    end
  end

  def permited_params
    params.permit(:quantity, :book_id)
  end

  def order_item
    @order_item = OrderItem.find(params[:id])
  end
end
