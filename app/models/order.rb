class Order < ApplicationRecord
  belongs_to :coupon, optional: true
  belongs_to :user, optional: true
  belongs_to :delivery
  belongs_to :credit_card
  has_many :order_items, dependent: :destroy
  has_many :addresses
  has_one :shipping_address, dependent: :destroy
  has_one :billing_address, dependent: :destroy

  validates :total_price, :status, presence: true
  validates :total_price, numericality: { greater_than: 0 }

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
