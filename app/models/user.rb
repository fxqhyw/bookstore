class User < ApplicationRecord
  has_many :reviews

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  validates_length_of :password, in: 8..30
end
