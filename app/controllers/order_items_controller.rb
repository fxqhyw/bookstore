class OrderItemsController < ApplicationController
  before_action :set_order_item, only: [:update, :destroy]

  def create
    @order_item = OrderItem.find_by(book_id: order_item_params[:book_id])
    if @order_item
      @order_item.quantity += order_item_params[:quantity].to_i
      @order_item.save!
    else
      @order_item = OrderItem.create(order_item_params)
    end
  end

  def update
    @order_item.update_attributes(order_item_params)
  end

  def destroy
    @order_item.destroy
  end

  private

  def order_item_params
    params.require(:order_item).permit(:quantity, :book_id, :cart_id)
  end

  def set_order_item
    @order_item = OrderItem.find(params[:id])
  end
end
