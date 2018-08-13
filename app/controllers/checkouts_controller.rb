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
      @addresses = CheckoutAddresser.new(billing_params: billing_params, shipping_params: shipping_params).call

      if params[:use_billing]['true'] == '1'
        update_billing
      else
        update_billing_and_shipping
      end
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

  def update_billing
    if @addresses[:billing].update(billing_params)
      render_wizard
    else
      render :address
    end
  end

  def update_billing_and_shipping
    unless @addresses[:billing].update(billing_params) || @addresses[:shipping].update(shipping_params)
      render :address
    else
      render_wizard
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
