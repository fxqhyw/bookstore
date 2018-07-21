class ShippingAddress < ApplicationRecord
  has_many :orders

  validates :first_name, :last_name, :address, :city,
            :zip, :country, :phone, presence: true
  validates :first_name, :last_name, :address, :city, length: { maximum: 50 }
  validates :first_name, :last_name, :city,
            format: { with: /\A[A-zА-я]+\z/, message: 'Only allows letters' }
  validates :address, format: { with: /\A[A-z0-9\s.,-]+\z/ }
  validates :zip, length: { maximum: 10 }, format: { with: /\A[0-9]+\z/, message: 'Only allows numbers' }
  validates :phone, length: { maximum: 15 }, format: { with: /\A^\+[0-9]+\z/, message: 'Should starts with +' }
end
