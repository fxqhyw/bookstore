class Coupon < ApplicationRecord
  validates_uniqueness_of :code
  validates_presence_of :discount
end
