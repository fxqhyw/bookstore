class Category < ApplicationRecord
  has_many :books

  validates :title, uniqueness: true, presence: true
end
