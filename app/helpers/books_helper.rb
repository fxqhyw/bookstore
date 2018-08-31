module BooksHelper
  def filter_books_title
    case request.GET[:filter]
    when 'newest' then I18n.t('button.newest_first')
    when 'popular' then I18n.t('button.popular_first')
    when 'low_to_high_price' then I18n.t('button.low_to_hight')
    when 'high_to_low_price' then I18n.t('button.hight_to_low')
    when 'title_a_z' then I18n.t('button.title_A-Z')
    when 'title_z_a' then I18n.t('button.title_Z-A')
    else I18n.t('button.newest_first')
    end
  end

  def sort_category_title
    request.GET[:category] ? Category.find(request.GET[:category]).title : I18n.t('button.all')
  end

  def main_image(book)
    url_for(book.images.first.varianr(resize: '400x380'))
  end

end
