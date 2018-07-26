class HomeController < ApplicationController
  def index
    @latest_books = Book.latest
    @best_sellers = Book.latest # TO DO
  end
end
