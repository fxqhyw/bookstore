class AddressesController < ApplicationController
  before_action :authenticate_user!

  def update
    @address = Address.where(user_id: params[:address][:user_id], type: params[:address][:type])
                      .first_or_create { |address| address.update(address_params) }

    if @address.update(address_params)
      redirect_to addresses_path, notice: 'Updated!'
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
