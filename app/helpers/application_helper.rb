module ApplicationHelper
  def authors_list(book)
    book.authors.map { |author| "#{author.first_name} #{author.last_name}" }.join(', ')
  end

  def flash_class(level)
    case level
    when 'notice' then 'alert alert-info'
    when 'success' then 'alert alert-success'
    when 'alert' then 'alert alert-danger'
    end
  end

  def order_date(order)
    order.created_at.strftime('%B %d, %Y')
  end

  def price_to_euro(price)
    "€#{price}"
  end

  def icon_book_image(book)
    url_for(book.images.first.variant(resize: '157!x214'))
  end
end
