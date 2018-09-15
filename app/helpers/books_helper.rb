module BooksHelper
  COUNT_OF_BOOKS_ON_ONE_PAGE = 12

  def filter_books_title
    return I18n.t("button.#{request.GET[:filter]}") if request.GET[:filter]
    I18n.t('button.newest')
  end

  def sort_category_title
    request.GET[:category] ? Category.find(request.GET[:category]).title : I18n.t('button.all')
  end

  def main_image(book)
    url_for(book.images.first.variant(resize: '400x380'))
  end

  def secondary_image(image)
    url_for(image.variant(resize: '150x190!'))
  end

  def slider_image(book)
    url_for(book.images.first.variant(resize: '250x316!'))
  end

  def more_books?(books)
    books.any? && books.size >= COUNT_OF_BOOKS_ON_ONE_PAGE
  end
end
