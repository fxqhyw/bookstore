class ApplicationController < ActionController::Base
  helper_method :current_order
  
  def current_order
    Order.find_or_initialize_by(id: session[:order_id])
  end
end
