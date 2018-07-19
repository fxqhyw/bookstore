module BooksHelper
  def dimension(book)
    "H:#{book.height}\" x W:#{book.width}\"" \
    " x D:#{book.depth}\""
  end

  def price_to_euro(price)
    "€#{price}"
  end
end
