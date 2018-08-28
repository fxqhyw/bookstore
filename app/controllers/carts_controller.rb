class CartsController < ApplicationController
  def update
    @order = Order.find_by_id(params[:order_id])
    @coupon = Coupon.find_by_code(params[:coupon_code])
    if @coupon
      @order.update(coupon_id: @coupon.id)
      redirect_to cart_path, notice: I18n.t('notice.coupon_added')
    else
      redirect_to cart_path, alert: I18n.t('notice.coupon_invalid')
    end
  end
end
