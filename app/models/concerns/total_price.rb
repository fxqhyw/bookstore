module TotalPrice
  extend ActiveSupport::Concern

  def total_price
    book.price * quantity
  end
end
