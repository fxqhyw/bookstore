class CheckoutCrediter
  def self.call(params)
    CreditCard.find_by(order_id: params[:order_id]) || CreditCard.new(order_id: params[:order_id])
  end
end
