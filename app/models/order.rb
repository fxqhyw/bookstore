class Order < ApplicationRecord
  has_many :order_items, dependent: :destroy
  belongs_to :coupon, optional: true
  belongs_to :shipping_address
  belongs_to :billing_address
  belongs_to :user
  belongs_to :delivery, optional: true
  belongs_to :credit_card, optional: true

  def subtotal
    order_items.sum(&:total_price)
  end

  def discount
    coupon.try(:discount) || 0.00
  end

  def order_total
    subtotal - discount
  end
end
