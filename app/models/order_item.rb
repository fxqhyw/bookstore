class OrderItem < ApplicationRecord
  belongs_to :book
  belongs_to :order

  validates :quantity, numericality: { greater_than: 0 }

  scope :created, -> { order(created_at: :desc) }

  def total_price
    book.price * quantity
  end

  def book_presents
    return unless book.quantity < quantity
    errors.add(:order_item, 'Not available')
  end
end
