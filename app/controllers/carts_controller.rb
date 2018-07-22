class CartsController < ApplicationController
  def show
    @order_items = current_order.order_items
  end

  def update
    current_order.update_attributes(coupon_id: @coupon.id) if coupon
    redirect_to cart_path
  end

  private

  def coupon
    @coupon ||= Coupon.find_by_code(params[:coupon_code])
  end
end
