module ApplicationHelper
  def authors_list(book)
    book.authors.map(&:name).join(', ')
  end

  def flash_class(level)
    case level
    when 'notice' then 'alert alert-info'
    when 'success' then 'alert alert-success'
    when 'alert' then 'alert alert-error'
    end
  end
end
