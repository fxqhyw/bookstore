module OrdersHelper
  def filter_orders_title
    return I18n.t("orders.#{request.GET[:filter]}") if request.GET[:filter]
    I18n.t('button.all')
  end
end
