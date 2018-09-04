class OrderDecorator < Draper::Decorator
  delegate_all

  def status_string
    case object.status
    when 'in_queue' then I18n.t('orders.waiting')
    when 'in_delivery' then I18n.t('orders.in_delivery')
    when 'delivered' then I18n.t('orders.delivered')
    end
  end

  def created_date
    object.created_at.strftime('%Y-%m-%d')
  end
end
