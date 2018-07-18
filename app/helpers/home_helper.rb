module HomeHelper
  def authors_list(book)
    book.authors.map(&:name).join(', ')
  end
end
