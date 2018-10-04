class SettingsAddresser < Rectify::Command
  attr_reader :params, :address

  def initialize(params)
    @params = params
  end

  def call
    @address = Address.find_or_initialize_by(user_id: params[:user_id], type: params[:type])
    return broadcast(:invalid, address) unless address.update(params)

    broadcast(:ok)
  end
end
