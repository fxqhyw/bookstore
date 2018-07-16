class Review < ApplicationRecord
  belongs_to :book
  belongs_to :user

  validates :title, :description, :rating, :status, presence: true
  validates :title, length: { maximum: 50 }
  validates :content, length: { maximum: 500 }
  validates :rating, numericality: { greater_than: 0, less_than_or_equal_to: 5 }
end
