class OrderItem < ApplicationRecord
  belongs_to :book
  belongs_to :cart
  belongs_to :order, optional: true

  validates :quantity, numericality: { greater_than: 0 }

  scope :created, -> { order(created_at: :desc) }

  def total_price
    book.price * quantity
  end

  private

  def book_presents
    return unless book.quantity < quantity
    errors.add(:order_item, 'Not available')
  end
end
