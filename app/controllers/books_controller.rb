class BooksController < ApplicationController
  before_action :authenticate_user!

  def index
    @books = Book.page(params[:page])
  end

  def show
    @book = Book.find_by_id(params[:id])
  end

  private
    def book_params
      params.require(:book).permit(:title)
    end
end
