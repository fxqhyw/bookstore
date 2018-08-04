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
end
