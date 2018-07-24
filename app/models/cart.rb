class Cart < ApplicationRecord
  has_many :order_items
  belongs_to :user, optional: true
  belongs_to :coupon, optional: true

  def subtotal
    order_items.sum(&:total_price)
  end

  def discount
    coupon.try(:discount) || 0.00
  end

  def order_total
    subtotal - discount
  end

  def items_count
    count = order_items.collect(&:quantity).compact.sum
    return if count.zero?
    count
  end
end
