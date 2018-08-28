class ApplicationController < ActionController::Base
  before_action :current_order, :categories

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, alert: exception.message
  end

  private

  def current_order
    return @current_order = current_user.orders.in_progress.first if user_signed_in?
    @current_order = Order.find_by_id(cookies.signed[:order_id])
  end

  def categories
    @categories = Category.with_books_count
  end
end
