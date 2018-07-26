class CartsController < ApplicationController
  def show
    @cart = current_cart
  end

  def update
    @coupon = Coupon.find_by_code(params[:coupon_code])
    if @coupon
      current_cart.update_attributes(coupon_id: @coupon.id)
      redirect_to cart_path, notice: 'Coupon was successfully added'
    else
      redirect_to cart_path, notice: 'Coupon is invalid'
    end
  end
end
