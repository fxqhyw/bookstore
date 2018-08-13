class CheckoutAddresser
  def initialize(billing_params:, shipping_params:)
    @billing_params = billing_params
    @shipping_params = shipping_params
  end

  def call
    addresses = {}
    addresses[:shipping] = ShippingAddress.find_by(order_id: @shipping_params[:order_id]) || ShippingAddress.new(@shipping_params)
    addresses[:billing] = BillingAddress.find_by(order_id: @billing_params[:order_id]) || BillingAddress.new(@billing_params)
    addresses
  end
end
