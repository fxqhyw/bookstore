class HomeController < ApplicationController
  def index
    @latest_books = Book.latest.decorate
    @best_sellers = Book.best_sellers.decorate
  end
end
