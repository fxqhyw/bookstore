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
      @addresses = {}
      @addresses[:shipping] = ShippingAddress.find_by(order_id: shipping_params[:order_id]) || ShippingAddress.new(shipping_params)
      @addresses[:billing] = BillingAddress.find_by(order_id: billing_params[:order_id]) || BillingAddress.new(billing_params)

      if params[:use_billing][:true] == '1'
        unless @addresses[:billing].update(billing_params)
          render :address
        else
          render_wizard
        end
      else
        unless @addresses[:billing].update(billing_params) || @addresses[:shipping].update(shipping_params)
          render :address
        else
          render_wizard
        end
      end
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
end
