module CheckoutUpdater
  extend ActiveSupport::Concern

  included do
    private

    def update_addresses
      @billing = BillingAddress.find_by(order_id: billing_params[:order_id]) || BillingAddress.new
      @shipping = ShippingAddress.find_by(order_id: shipping_params[:order_id]) || ShippingAddress.new

      @billing.update(billing_params)
      if params[:use_billing]
        render_wizard @billing
      else
        @shipping.update(shipping_params)
        render_wizard @shipping
      end
    end

    def update_delivery
      @current_order.delivery_id = params[:delivery_id] if params[:delivery_id]
      render_wizard @current_order
    end

    def update_credit_card
      @credit_card = CreditCard.find_by(order_id: credit_card_params[:order_id]) || CreditCard.new
      @credit_card.update(credit_card_params)
      render_wizard @credit_card
    end

    def confirm_order
      @current_order.total_price = @current_order.order_total
      @current_order.number = "#R#{Time.now.nsec}" + @current_order.id.to_s
      @current_order.confirm
      @placed_order = @current_order
      if @current_order.save
        CheckoutMailer.with(user: current_user, order: @current_order).complete_email.deliver_later
        render :complete
      else
        render_wizard
      end
    end

    def billing_params
      params.require(:billing).permit(:first_name, :last_name, :address, :city, :zip, :country, :phone, :order_id)
    end

    def shipping_params
      params.require(:shipping).permit(:first_name, :last_name, :address, :city, :zip, :country, :phone, :order_id)
    end

    def credit_card_params
      params.require(:credit_card).permit(:number, :name, :expiration_date, :cvv, :order_id)
    end
  end
end
