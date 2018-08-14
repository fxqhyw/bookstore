class CreditCard < ApplicationRecord
  belongs_to :order

  validates :name, :number, :expiration_date, :cvv, presence: true
  validates :name, length: { maximum: 30 }, format: { with: /\A[A-z\s]+\z/,
                                                      message: "must consist of only letters" }
  validates :number, length: { minimum: 13, maximum: 18 }, format: { with: /\A[0-9]+\z/,
                                                                     message: "must consist of only digits" }
  validates :expiration_date, length: { is: 5 }, format: { with: /\A(0{1}([0-9]){1}|1{1}([0-2]){1})\/\d{2}\z/,
                                                           message: "format must be MM/YY" }
  validates :cvv, length: { minimum: 3, maximum: 4 }, format: { with: /\A[0-9]+\z/, message: "must consist of only 3 or 4 digits" }
end
