class CheckoutsController < ApplicationController
  include Wicked::Wizard

  steps :address, :delivery, :payment, :confirm, :complete

  def show
    return redirect_to cart_path, alert: 'Cart is empty' if empty_cart?
    jump_to(CheckoutStep.new(steps: steps, order: @current_order).call)
    render_wizard
  end

  private

  def empty_cart?
    @current_order.order_items.empty?
  end
end
