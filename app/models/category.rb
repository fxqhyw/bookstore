class Category < ApplicationRecord
  has_many :books
  validates :title, uniqueness: true, presence: true

  scope :with_books_count, -> { joins(:books).select('categories.*, count(books) as books_count').group('categories.id') }
end
