class CreditCard < ApplicationRecord
  validates :first_name, :last_name, :number, :expiration_date, :cvv, presence: true
  validates :first_name, :last_name, length: { maximum: 30 }, format: { with: /\A[a-zA-Z]\z/,
                                                                        message: "Name must contain only latin letters" }
  validates :number, length: { minimum: 13, maximum: 18 }, format: { with: /\A[0-9]+\z/,
                                                                     message: "Invalid card number!"}
  validates :expiration_date, length: { is: 5 }, format: { with: /\A(0{1}([0-9]){1}|1{1}([0-2]){1})\/\d{2}\z/,
                                                           message: "The expiration date format must be MM/YY" }
  validates :cvv, length: { is: 3 }, format: { with: /\A[0-9]+\z/, message: "Invalid CVV code!"}
end
