class ApplicationController < ActionController::Base
  helper_method :current_cart, :categories

  def current_cart
    if user_signed_in?
      current_user.cart ||= Cart.create(user_id: current_user.id)
    else
      cart = Cart.find_by_id(session[:cart_id]) || Cart.create
      session[:cart_id] = cart.id
      cart
    end
  end

  def categories
    @categories = Category.with_books_count
  end
end
