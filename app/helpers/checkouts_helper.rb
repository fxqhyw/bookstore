module CheckoutsHelper
  def active_step(current_step)
    'active' if current_step == step
  end

  def address_error?(type, field)
    address = order_address(type)
    address.errors.include?(field) if address
  end

  def address_error_message(type, field)
    address = order_address(type)
    address.errors.messages[field][0] if address
  end

  def address_saved_value(type, field)
    order_address(type).try(:[], field) || user_address(type).try(:[], field)
  end

  private

  def user_address(type)
    current_user.addresses.select { |address| address.type == type }.first
  end

  def order_address(type)
    @current_order.addresses.select { |address| address.type == type }.first
  end
end
