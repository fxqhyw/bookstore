class CheckoutAddresser
  def self.call(billing: nil, shipping: nil)
    return BillingAddress.find_by(order_id: billing[:order_id]) || BillingAddress.new(billing) if billing
    ShippingAddress.find_by(order_id: shipping[:order_id]) || ShippingAddress.new(shipping) if shipping
  end
end
