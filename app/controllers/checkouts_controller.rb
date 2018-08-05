class CheckoutsController < ApplicationController
  include Wicked::Wizard

  steps :address, :delivery, :payment, :confirm, :complete

  private

  def initialize_order
    @order = Order.new(user_id: current_user.id)
    @order.order_items << current_cart.order_items
    @order.coupon_id = current_cart.coupon_id if current_cart.coupon_id
  end
end
