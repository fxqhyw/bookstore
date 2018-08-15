class BookDecorator < Draper::Decorator
  delegate_all

  def authors_list
    object.authors.map { |author| "#{author.first_name} #{author.last_name}" }.join(', ')
  end
end
