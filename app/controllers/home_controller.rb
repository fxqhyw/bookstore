class HomeController < ApplicationController
  def index
    @latest_books = Book.latest
    @best_sellers = Book.first(4) # TO DO
  end
end
