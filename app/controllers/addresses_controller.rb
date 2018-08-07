class AddressesController < ApplicationController
  before_action :authenticate_user!

  def update
    @address = AddressHandler.new(address_params).call

    if @address.update(address_params)
      redirect_to address_path, notice: 'Updated!'
    else
      render 'edit'
    end
  end

  private

  def address_params
    params.require(:address).permit(:first_name, :last_name, :address, :city, :zip,
                                    :country, :phone, :type, :user_id)
  end
end
