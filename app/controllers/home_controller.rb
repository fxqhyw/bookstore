class HomeController < ApplicationController
  def index
    @latest_books = Book.latest.decorate
    @best_sellers = Book.latest.decorate # TO DO
  end
end
