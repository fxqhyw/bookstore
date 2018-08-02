class ApplicationController < ActionController::Base
  helper_method :categories, :current_cart

  def current_cart
    if user_signed_in?
      return current_user.cart if current_user.cart
      Cart.create(user_id: current_user.id)
    else
      cart = Cart.find_by_id(session[:cart_id])
      return cart if cart
      cart = Cart.create
      session[:cart_id] = cart.id
      cart
    end
  end

  def categories
    Category.with_books_count
  end
end
