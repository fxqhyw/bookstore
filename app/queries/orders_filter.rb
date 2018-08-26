class OrdersFilter
  def initialize(orders:, params:)
    @orders = orders
    @params = params
  end

  def call
    case @params[:filter]
    when 'waiting_for_proccesing' then waiting_for_proccesing
    when 'in_delivery' then in_delivery
    when 'delivered' then delivered
    else @orders
    end
  end

  private

  def waiting_for_proccesing
    @orders.in_queue
  end

  def in_delivery
    @orders.in_delivery
  end

  def delivered
    @orders.delivered
  end
end
