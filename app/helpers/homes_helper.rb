module HomesHelper
  def short_description(book)
    book.description[0...415] + '...'
  end
end
