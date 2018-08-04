class Coupon < ApplicationRecord
  has_many :orders, dependent: :nullify
  has_many :carts, dependent: :nullify

  validates_uniqueness_of :code
  validates_presence_of :discount
end
