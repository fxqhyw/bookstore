class Coupon < ApplicationRecord
  has_many :orders
  has_many :carts

  validates_uniqueness_of :code
  validates_presence_of :discount
end
