module BooksHelper
  TITLES = {
    newest: 'Newest first',
    popular: 'Popular first',
    low_to_high_price: 'Price: Low to high',
    high_to_low_price: 'Price: High to low',
    title_a_z: 'A - Z',
    title_z_a: 'Z - A'
  }.freeze

  def dimension(book)
    "H:#{book.height}\" x W:#{book.width}\"" \
    " x D:#{book.depth}\""
  end

  def price_to_euro(price)
    "€#{price}"
  end

  def filter_title
    request.GET[:filter] ? TITLES[request.GET[:filter].to_sym] : TITLES[:newest]
  end
end
