class Book < ApplicationRecord
  has_and_belongs_to_many :authors
  has_many :order_items, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many_attached :images, dependent: :destroy
  belongs_to :category

  validates :title, :description, :price, :published_at, :materials, :height, :width, :depth, :quantity, presence: true
  validates :price, :height, :width, :depth, :quantity, numericality: { greater_than_or_equal_to: 0.01 }
  validates :published_at, numericality: { less_than_or_equal_to: Time.current.year }

  scope :latest, -> { order(created_at: :desc).limit(3) }
  scope :best_sellers, -> { joins(:order_items).group('id').order(Arel.sql('SUM(order_items.quantity) desc')).limit(4) }
end
