class OrderItemsController < ApplicationController
  respond_to :html, :js, only: [:index]

  def create
    @order_item = OrderItem.create(book_id: params[:order_item][:book_id], cart_id: current_cart.id)
  end

  private

  def order_item_params
    params.require(:order_item).permit(:quantity, :book_id)
  end
end
