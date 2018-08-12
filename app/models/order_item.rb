class OrderItem < ApplicationRecord
  belongs_to :book
  belongs_to :order

  validates :quantity, numericality: { greater_than: 0 }

  scope :created, -> { order(created_at: :desc) }

  def total_price
    book.price * quantity
  end
end
