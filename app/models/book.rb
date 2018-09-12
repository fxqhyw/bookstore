class Book < ApplicationRecord
  has_and_belongs_to_many :authors
  has_many :order_items, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many_attached :images, dependent: :destroy
  belongs_to :category, counter_cache: true

  validates :title, :description, :price, :published_at, :materials, :height, :width, :depth, :quantity, presence: true
  validates :price, :height, :width, :depth, :quantity, numericality: { greater_than_or_equal_to: 0.01 }
  validates :published_at, numericality: { less_than_or_equal_to: Time.current.year }
  validate :correct_images_type

  scope :latest, -> { order(created_at: :desc).limit(3) }
  scope :best_sellers, -> { joins(:order_items).group('id').order(Arel.sql('SUM(order_items.quantity) desc')).limit(4) }

  private

  def correct_images_type
    return unless images.attached?

    images.each do |image|
      errors.add(:images, 'must be a JPEG or PNG') unless image.content_type.in?(%w[image/jpeg image/png])
    end
  end
end
