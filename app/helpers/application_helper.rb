module ApplicationHelper
  def flash_class(level)
    {
      'notice' => 'alert alert-info',
      'success' => 'alert alert-success',
      'alert' => 'alert alert-danger'
    }[level]
  end

  def price_to_euro(price)
    "€#{price}"
  end

  def icon_book_image(book)
    url_for(book.images.first.variant(resize: '158x198!'))
  end
end
