module OrdersHelper
  def filter_orders_title
    case request.GET[:filter]
    when 'waiting_for_proccesing' then I18n.t('orders.waiting')
    when 'in_delivery' then I18n.t('orders.in_delivery')
    when 'delivered' then I18n.t('orders.delivered')
    else I18n.t('button.all')
    end
  end

  def order_status(status)
    case status
    when 'in_queue' then I18n.t('orders.waiting')
    when 'in_delivery' then I18n.t('orders.in_delivery')
    when 'delivered' then I18n.t('orders.delivered')
    end
  end
end
