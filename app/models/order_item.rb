class OrderItem < ApplicationRecord
  belongs_to :book
  belongs_to :cart
  belongs_to :order, optional: true

  def total_price
    book.price * quantity
  end

  private

  def increase_book_quantity
    book.quantity += quantity
    book.save!
  end

  def decrease_book_quantity
    book.quantity -= quantity
    book.save!
  end

  def book_presents
    return unless book.quantity < quantity
    errors.add(:order_item, 'Not available')
  end
end
