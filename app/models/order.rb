class Order < ApplicationRecord
  include AASM

  belongs_to :user, optional: true
  belongs_to :coupon, optional: true
  belongs_to :delivery, optional: true
  has_many :order_items, dependent: :destroy
  has_one :shipping_address, dependent: :destroy
  has_one :billing_address, dependent: :destroy
  has_one :credit_card, dependent: :destroy

  validates :status, presence: true

  scope :in_progress, -> { where(status: :in_progress) }
  scope :in_queue, -> { where(status: :in_queue) }
  scope :in_delivery, -> { where(status: :in_delivery) }
  scope :delivered, -> { where(status: :delivered) }

  aasm column: 'status', whiny_transitions: false do
    state :in_progress, initial: true
    state :in_queue, :in_delivery, :delivered, :canceled

    event :confirm do
      transitions from: :in_progress, to: :in_queue
    end

    event :start_delivery do
      transitions from: :in_queue, to: :in_delivery
    end

    event :finish_delivery do
      transitions from: :in_delivery, to: :delivered
    end

    event :cancel do
      transitions from: %i[in_queue in_delivery in_progress], to: :canceled
    end
  end

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
