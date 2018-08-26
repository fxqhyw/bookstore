module OrdersHelper
  def order_status(status)
    case status
    when 'in_queue'
      'Waiting for processing'
    when 'in_delivery'
      'In delivery'
    when 'delivered'
      'Delivered'
    end
  end
end
