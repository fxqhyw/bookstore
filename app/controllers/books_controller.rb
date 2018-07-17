class BooksController < ApplicationController
  before_action :authenticate_user!
  def index
    render 'catalog'
  end
end
