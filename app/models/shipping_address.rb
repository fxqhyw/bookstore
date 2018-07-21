class ShippingAddress < ApplicationRecord
  has_many :orders
end
