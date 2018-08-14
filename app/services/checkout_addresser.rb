class CheckoutAddresser
  def self.call(billing: nil, shipping: nil)
    return BillingAddress.find_by(order_id: billing[:order_id]) || BillingAddress.new if billing
    ShippingAddress.find_by(order_id: shipping[:order_id]) || ShippingAddress.new if shipping
  end
end
