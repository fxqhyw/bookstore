class ApplicationController < ActionController::Base
  helper_method :categories, :current_order

  def current_order
    if user_signed_in?
      return current_user.orders.in_progress.first if current_user.orders.in_progress.first
      Order.create(user_id: current_user.id)
    else
      order = Order.find_by_id(session[:order_id])
      return order if order
      order = Order.create
      session[:order_id] = order.id
      order
    end
  end

  def categories
    Category.with_books_count
  end
end
