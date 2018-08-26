class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @orders = OrdersFilter.new(orders: current_user.orders.placed, params: params).call
  end
end
