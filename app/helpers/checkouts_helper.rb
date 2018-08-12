module CheckoutsHelper
  def active_step(current_step)
    'active' if current_step == step
  end

  def address_error?(field:, tag:)
    return @addresses[tag.to_sym].errors.include?(field) if @addresses.try(:[], tag.to_sym)
  end

  def address_error_message(field:, tag:)
    return @addresses[tag.to_sym].errors.messages[field][0] if address_error?(field: field, tag: tag)
  end

  def address_saved_value(type:, field:, tag:)
    user_address_field(type, field) || order_address_field(type, field) || inputed_address_field(tag, field)
  end

  private

  def user_address_field(type, field)
    current_user.addresses.find_by_type(type).try(:[], field)
  end

  def order_address_field(type, field)
    @current_order.addresses.find_by_type(type).try(:[], field)
  end

  def inputed_address_field(tag, field)
    @addresses.try(:[], tag.to_sym).try(:[], field)
  end
end
