module CheckoutsHelper
  def active_step(current_step)
    'active' if current_step == step
  end

  def address_error?(field:, tag:)
    return @billing.errors.include?(field) if @billing && tag == 'billing'
    @shipping.errors.include?(field) if @shipping && tag == 'shipping'
  end

  def address_error_message(field:, tag:)
    return @billing.errors[field].to_sentence if @billing && tag == 'billing'
    @shipping.errors[field].to_sentence if @shipping && tag == 'shipping'
  end

  def address_saved_value(field:, tag:)
    order_address_field(tag, field) || user_address_field(tag, field) || inputed_address_field(tag, field)
  end

  def checked_delivery?(delivery_id)
    current_order.delivery_id == delivery_id
  end

  def card_error?(field)
    @credit_card.errors.include?(field) if @credit_card
  end

  def card_error_message(field)
    @credit_card.errors[field].to_sentence if @credit_card
  end

  def card_saved_value(field)
    current_order.credit_card.try(field) || @credit_card.try(field)
  end

  def client_name(address)
    address.first_name + ' ' + address.last_name
  end

  def secret_card_number(number)
    '*** *** *** ' + number[-4, 4]
  end

  private

  def user_address_field(tag, field)
    return current_user.billing_address.try(field) if tag == 'billing'
    current_user.shipping_address.try(field) if tag == 'shipping'
  end

  def order_address_field(tag, field)
    return current_order.billing_address.try(field) if tag == 'billing'
    current_order.shipping_address.try(field) if tag == 'shipping'
  end

  def inputed_address_field(tag, field)
    return @billing.try(field) if tag == 'billing'
    @shipping.try(field) if tag == 'shipping'
  end
end
