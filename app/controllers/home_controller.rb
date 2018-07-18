class HomeController < ApplicationController
  def index
    @latest_books = Book.latest
  end
end
