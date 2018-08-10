class CheckoutsController < ApplicationController
  include Wicked::Wizard

  steps :address, :delivery, :payment, :confirm, :complete

  def show
    showable_step = CheckoutStep.new(steps: steps, current_step: step, order: @current_order, edit: params[:edit]).call
    jump_to(showable_step) unless step == showable_step
    render_wizard
  end

  private

  def empty_cart?
    @current_order.order_items.empty?
  end
end
