class ApplicationController < ActionController::Base
  helper_method :categories
  before_action :current_cart

  def current_cart
    if user_signed_in?
      @cart = current_user.cart
      @cart ||= Cart.create(user_id: current_user.id)
    else
      @cart = Cart.find_by_id(session[:cart_id])
      return if @cart
      @cart = Cart.create
      session[:cart_id] = @cart.id
    end
  end

  def categories
    Category.with_books_count
  end
end
