class CartsController < ApplicationController
  def show
    @cart = current_cart
  end

  def update
    @coupon = Coupon.find_by_code(params[:coupon_code])
    if @coupon
      current_cart.update_attributes(coupon_id: @coupon.id)
      redirect_to cart_path
    else
      redirect_to cart_path, alert: "Wrong coupon"
    end
  end
end
