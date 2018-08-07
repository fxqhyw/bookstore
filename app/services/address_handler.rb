class AddressHandler
  def initialize(params)
    @params = params
  end

  def call
    address = Address.find_by(user_id: @params[:user_id], type: @params[:type])
    return address if address
    Address.new(@params)
  end
end
