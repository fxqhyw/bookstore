class BookDecorator < Draper::Decorator
  delegate_all

  def dimensions_string
    "H:#{object.height}\" x W:#{object.width}\"" \
    " x D:#{object.depth}\""
  end
end
