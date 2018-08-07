class BooksFilter
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
    Book.where(category_id: @params[:category])
  end

  def by_filter
    case @params[:filter]
    when 'newest' then newest
    when 'popular' then popular
    when 'low_to_high_price' then low_to_high_price
    when 'high_to_low_price' then high_to_low_price
    when 'title_a_z' then title_a_z
    when 'title_z_a' then title_z_a
    else newest
    end
  end

  def newest
    @books.order(created_at: :desc)
  end

  def popular
    @books # TO DO
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
