module ApplicationHelper
  def flash_class(level)
    case level
    when 'notice' then 'alert alert-info'
    when 'success' then 'alert alert-success'
    when 'alert' then 'alert alert-danger'
    end
  end

  def price_to_euro(price)
    "€#{price}"
  end

  def icon_book_image(book)
    url_for(book.images.first.variant(resize: '158x198!'))
  end
end
