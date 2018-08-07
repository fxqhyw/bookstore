class CheckoutsController < ApplicationController
  include Wicked::Wizard

  before_action :authenticate_user!

  steps :address, :delivery, :payment, :confirm, :complete

  def show
    return redirect_to cart_path, alert: 'Cart is empty' if empty_cart?
    @order = current_order
    jump_to(CheckoutStep.new(steps: steps, order: @order).call)
    render_wizard
  end

  private

  def empty_cart?
    current_order.order_items.empty?
  end
end
