class BooksController < ApplicationController
  def index
    @category_id = params[:category]
    @filter = params[:filter]
    @categories = categories
    @books = BooksFilter.new(params: permited_params).call.page(params[:page])
  end

  def show
    @book = Book.find_by_id(params[:id])
    @reviews = @book.reviews
  end

  private

  def permited_params
    params.permit(:filter, :category)
  end
end
