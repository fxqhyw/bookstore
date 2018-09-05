class BookDecorator < ApplicationDecorator
  delegate_all

  def dimensions_string
    "H:#{object.height}\" x W:#{object.width}\"" \
    " x D:#{object.depth}\""
  end

  def authors_list
    object.authors.map { |author| "#{author.first_name} #{author.last_name}" }.join(', ')
  end
end
