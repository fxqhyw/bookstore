class SettingsAddresser
  def self.call(params)
    Address.find_by(user_id: params[:user_id], type: params[:type]) || Address.new(user_id: params[:user_id], type: params[:type])
  end
end
