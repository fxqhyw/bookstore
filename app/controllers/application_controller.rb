class ApplicationController < ActionController::Base
  before_action :current_order, :categories

  private

  def current_order
    if user_signed_in?
      @current_order = current_user.orders.in_progress.first.decorate || Order.create(user_id: current_user.id).decorate
    else
      @current_order = Order.find_by_id(cookies.encrypted[:order_id]).decorate || Order.create.decorate
      cookies.encrypted[:order_id] = { value: @current_order.id, expires: 1.mouth.from_now }
    end
  end

  def categories
    @categories = Category.with_books_count
  end
end
