class Book < ApplicationRecord
  has_and_belongs_to_many :authors
  has_many :order_items
  belongs_to :category

  validates :title, :description, :price, :published_at, :height, :width, :depth, :quantity, presence: true
  validates :price, :height, :width, :depth, :quantity, numericality: { greater_than: 0 }
  validates :published_at, numericality: { less_than_or_equal_to: Time.current.year }

  scope :latest, -> { order(created_at: :desc).limit(3) }
end
