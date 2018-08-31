module ReviewerInfo
  extend ActiveSupport::Concern

  def avatar_letter
    user.email[0].capitalize
  end

  def reviewer_name
    full_name(user.billing_address) || full_name(user.shipping_address) || user.email
  end

  private

  def full_name(address)
    address.first_name + ' ' + address.last_name if address
  end
end
