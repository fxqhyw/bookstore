class BooksController < ApplicationController
  def index
    @books = BooksFilter.new(params: permited_params).call.page(params[:page])
  end

  def show
    @book = Book.find(params[:id]).decorate
    @reviews = @book.reviews.approved.decorate
  end

  private

  def permited_params
    params.permit(:filter, :category)
  end
end
