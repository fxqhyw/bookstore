class BooksController < ApplicationController
  before_action :authenticate_user!

  def index
    @category_id = params[:category]
    @categories = Category.with_books_count
    @books = BooksFilter.new(params: permited_params).call.page(params[:page])
  end

  def show
    @book = Book.find_by_id(params[:id])
  end

  private

  def permited_params
    params.permit(:filter, :category)
  end
end
