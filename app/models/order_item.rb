class OrderItem < ApplicationRecord
  belongs_to :book
  belongs_to :cart
  belongs_to :order
end
