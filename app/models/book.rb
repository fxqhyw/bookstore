class Book < ApplicationRecord
  has_and_belongs_to_many :authors
  belongs_to :category

  validates :title, :description, :price, :published_at, :height, :width, :depth, :category_id, presence: true
  validates :price, :height, :width, :depth, numericality: { greater_than: 0 }
  validates :published_at, numericality: { less_than_or_equal_to: Time.current.year }

  scope :latest, -> { order(created_at: :desc) }
end
