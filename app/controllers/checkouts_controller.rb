class CheckoutsController < ApplicationController
  include Wicked::Wizard
  include CheckoutUpdater

  before_action :authenticate_user!, only: [:update]

  steps :login, :address, :delivery, :payment, :confirm

  def show
    return redirect_to cart_path, alert: 'Cart is empty' if empty_cart?
    showable_step = CheckoutStepper.new(steps: steps, current_step: step, order: @current_order,
                                        edit: params[:edit], user: current_user).call
    jump_to(showable_step) unless step == showable_step
    render_wizard
  end

  def update
    case step
    when :address
      update_addresses
    when :delivery
      update_delivery
    when :payment
      update_credit_card
    when :confirm
      confirm_order
    end
  end

  private

  def empty_cart?
    @current_order.order_items.empty?
  end
end
