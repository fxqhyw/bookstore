class Order < ApplicationRecord
  has_many :order_items
  belongs_to :shipping_address
  belongs_to :billing_address
  belongs_to :user
  belongs_to :delivery
  belongs_to :credit_card
end
