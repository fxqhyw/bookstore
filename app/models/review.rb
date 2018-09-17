class Review < ApplicationRecord
  include AASM

  belongs_to :book
  belongs_to :user

  validates :title, :description, :rating, :status, presence: true
  validates :title, length: { maximum: 80 }
  validates :description, length: { maximum: 500 }
  validates :rating, numericality: { greater_than: 0, less_than_or_equal_to: 5 }

  scope :approved, -> { where(status: :approved).order(created_at: :desc) }

  aasm column: 'status', whiny_transitions: false do
    state :unprocessed, initial: true
    state :approved, :rejected

    event :approve do
      transitions from: :unprocessed, to: :approved
    end

    event :reject do
      transitions from: :unprocessed, to: :rejected
    end

    event :unprocess do
      transitions from: %i[rejected approved], to: :unprocessed
    end
  end
end
