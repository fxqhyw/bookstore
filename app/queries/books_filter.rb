class BooksFilter
  FILTERS = {
    'newest' => :newest,
    'popular' => :popular,
    'high_to_low_price' => :high_to_low_price,
    'low_to_high_price' => :low_to_high_price,
    'title_a_z' => :title_a_z,
    'title_z_a' => :title_z_a
  }.freeze

  def initialize(books: Book.all, params:)
    @books = books
    @params = params
  end

  def call
    @books = by_category if @params[:category]
    @books = by_filter
  end

  private

  def by_category
    @books.where(category_id: @params[:category])
  end

  def by_filter
    return send(FILTERS[@params[:filter]]) if FILTERS[@params[:filter]]

    newest
  end

  def newest
    @books.order(created_at: :desc)
  end

  def popular
    @books.left_outer_joins(:order_items).group('id').order(Arel.sql('COUNT(order_items) desc'))
  end

  def low_to_high_price
    @books.order(price: :asc)
  end

  def high_to_low_price
    @books.order(price: :desc)
  end

  def title_a_z
    @books.order(title: :asc)
  end

  def title_z_a
    @books.order(title: :desc)
  end
end
