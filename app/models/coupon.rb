class Coupon < ApplicationRecord
  has_many :orders

  validates_uniqueness_of :code
  validates_presence_of :discount
end
