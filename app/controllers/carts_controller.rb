class CartsController < ApplicationController
  def show
    @cart = current_cart
    @order_items = current_cart.order_items
  end

  def update
  end

  private

  def coupon
    @coupon ||= Coupon.find_by_code(params[:coupon_code])
  end
end
