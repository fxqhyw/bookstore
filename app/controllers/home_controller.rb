class HomeController < ApplicationController
  def index
    @latest_books = Book.latest
    @best_sellers = Book.best_sellers.limit(4)
  end
end
