module BooksHelper
  TITLES = {
    newest: I18n.t('button.newest_first'),
    popular: I18n.t('button.popular_first'),
    low_to_high_price: I18n.t('button.low_to_hight'),
    high_to_low_price: I18n.t('button.hight_to_low'),
    title_a_z: I18n.t('button.title_A-Z'),
    title_z_a: I18n.t('button.title_Z-A')
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
