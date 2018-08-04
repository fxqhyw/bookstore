module SettingsHelper
  def has_error?(type, field)
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

  def tab?(tab)
    return true if !params.key?(:tab) && tab == 'address'
    params[:tab] == tab
  end

  private

  def address(type)
    current_user.addresses.select { |address| address.type == type }.first
  end

  def correct_type?(type)
    @address.try(:type) == type
  end
end
