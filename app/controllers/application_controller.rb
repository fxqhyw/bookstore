class ApplicationController < ActionController::Base
  helper_method :categories
  before_action :current_order

  private

  def current_order
    if user_signed_in?
      @current_order = current_user.orders.in_progress
      @current_order ||= Order.create(user_id: current_user.id)
    else
      @current_order = Order.find_by_id(session[:order_id])
      @current_order ||= Order.create
      session[:order_id] = @current_order.id
    end
  end

  def categories
    Category.with_books_count
  end
end
