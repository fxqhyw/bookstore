class CheckoutsController < ApplicationController
  include Wicked::Wizard

  steps :login, :address, :delivery, :payment, :confirm, :complete

  def show
    showable_step = CheckoutStepper.new(steps: steps, current_step: step, order: @current_order,
                                        edit: params[:edit], user: current_user).call
    jump_to(showable_step) unless step == showable_step
    render_wizard
  end

  def update
    case step
    when :address
      @billing = CheckoutAddresser.call(billing: billing_params)
      @shipping = CheckoutAddresser.call(shipping: shipping_params)
      update_addresses
    when :delivery
      update_delivery
    end
  end

  private

  def billing_params
    params.require(:billing).permit(:first_name, :last_name, :address, :city, :zip, :country, :phone, :order_id)
  end

  def shipping_params
    params.require(:shipping).permit(:first_name, :last_name, :address, :city, :zip, :country, :phone, :order_id)
  end

  def empty_cart?
    @current_order.order_items.empty?
  end

  def update_addresses
    @billing.update(billing_params)
    if params[:use_billing]['true'] == '1'
      render_wizard @billing
    else
      @shipping.update(shipping_params)
      render_wizard @shipping
    end
  end

  def update_delivery
    if params[:delivery_id]
      @current_order.delivery_id = params[:delivery_id]
      render_wizard @current_order
    else
      render_wizard
    end
  end
end
