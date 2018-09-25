class ApplicationController < ActionController::Base
  helper_method :current_order

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, alert: exception.message
  end

  private

  def current_order
    return @current_order ||= current_user.orders.in_progress.first if user_signed_in?

    @current_order ||= Order.find_by_id(cookies.signed[:order_id])
  end
end
