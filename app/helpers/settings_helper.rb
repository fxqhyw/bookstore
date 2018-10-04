module SettingsHelper
  def error?(type, field)
    return unless correct_type?(type)

    @address.errors.include?(field)
  end

  def error_message(type, field)
    return unless correct_type?(type)

    @address.errors.messages[field][0] if @address
  end

  def saved_value(type, field)
    address = address(type)
    return @address[field] if @address.try(:[], field) && correct_type?(type)

    address[field] if address
  end

  private

  def address(type)
    return current_user.billing_address if type == 'BillingAddress'

    current_user.shipping_address if type == 'ShippingAddress'
  end

  def correct_type?(type)
    @address.try(:type) == type
  end
end
