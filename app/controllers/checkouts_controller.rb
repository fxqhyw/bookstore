class CheckoutsController < ApplicationController
  include Wicked::Wizard

  before_action :authenticate_user!

  steps :address, :delivery, :payment, :confirm, :complete

  def show
    check_empty_cart
    @order = current_user.orders.in_progress.first
    initialize_order unless @order
    render_wizard
  end

  private

  def initialize_order
    @order = Order.create(user_id: current_user.id)
    @order.order_items << current_cart.order_items
    @order.coupon_id = current_cart.coupon_id if current_cart.coupon_id
  end

  def check_empty_cart
    redirect_to cart_path, alert: 'Your cart is empty' unless current_cart.order_items.any?
  end
end
