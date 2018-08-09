class Address < ApplicationRecord
  belongs_to :order, optional: true
  belongs_to :user, optional: true

  validates :first_name, :last_name, :address, :city,
            :zip, :country, :phone, presence: true
  validates :first_name, :last_name, :address, :city, length: { maximum: 50 }
  validates :zip, length: { maximum: 10 }, format: { with: /\A[0-9]+\z/, message: 'Only allows numbers' }
  validates :phone, length: { maximum: 20 }, format: { with: /\A^\+[0-9]+\z/, message: 'Should starts with +' }
end
