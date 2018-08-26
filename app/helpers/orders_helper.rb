module OrdersHelper
  TITLES = {
    waiting_for_proccesing: I18n.t('orders.waiting'),
    in_delivery: I18n.t('orders.in_delivery'),
    delivered: I18n.t('orders.delivered')
  }.freeze

  def filter_title
    request.GET[:filter] ? TITLES[request.GET[:filter].to_sym] : ''
  end

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
