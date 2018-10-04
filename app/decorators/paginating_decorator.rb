class PaginatingDecorator < Draper::CollectionDecorator
  delegate :current_page, :next_page, :total_pages, :last_page?, :limit_value
end
