module CheckoutsHelper
  def active_step(current_step)
    'active' if current_step == step
  end

  def address_error?(field:, tag:)
    return @billing.errors.include?(field) if @billing && tag == 'billing'
    @shipping.errors.include?(field) if @shipping && tag == 'shipping'
  end

  def address_error_message(field:, tag:)
    return @billing.errors.messages[field][0] if @billing && tag == 'billing'
    @shipping.errors.messages[field][0] if @shipping && tag == 'shipping'
  end

  def address_saved_value(type:, field:, tag:)
    user_address_field(type, field) || order_address_field(type, field) || inputed_address_field(tag, field)
  end

  def checked_delivery?(delivery_id)
    @current_order.delivery_id == delivery_id
  end

  private

  def user_address_field(type, field)
    current_user.addresses.find_by_type(type).try(:[], field)
  end

  def order_address_field(type, field)
    @current_order.addresses.find_by_type(type).try(:[], field)
  end

  def inputed_address_field(tag, field)
    return @billing.try(:[], field) if tag == 'billing'
    @shipping.try(:[], field) if tag == 'shipping'
  end
end
