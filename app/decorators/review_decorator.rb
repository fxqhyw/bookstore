class ReviewDecorator < ApplicationDecorator
  delegate_all

  def avatar_letter
    object.user.email[0].capitalize
  end

  def reviewer_name
    full_name(object.user.billing_address) || full_name(object.user.shipping_address) || object.user.email
  end

  private

  def full_name(address)
    address.first_name + ' ' + address.last_name if address
  end
end
