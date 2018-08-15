class CartsController < ApplicationController
  def update
    @coupon = Coupon.find_by_code(params[:coupon_code])
    if @coupon
      @order.update(coupon_id: @coupon.id)
      redirect_to cart_path, notice: 'Coupon was successfully added'
    else
      redirect_to cart_path, alert: 'Coupon is invalid'
    end
  end
end
