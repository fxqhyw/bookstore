class OrderDecorator < Draper::Decorator
  delegate_all

  def subtotal
    object.order_items.sum(&:total_price)
  end

  def discount
    object.coupon.try(:discount) || 0.00
  end

  def order_total
    if object.coupon
      object.order_items.sum(&:total_price) - object.coupon.discount
    else
      object.order_items.sum(&:total_price)
    end
  end

  def items_count
    count = object.order_items.collect(&:quantity).compact.sum
    return if count.zero?
    count
  end
end
