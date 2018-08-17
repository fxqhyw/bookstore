class RegistrationsController < Devise::RegistrationsController
  after_action :transfer_order_to_user, only: [:create]

  private

  def transfer_order_to_user
    @current_order.update(user_id: @user.id)
  end

  protected

  def update_resource(resource, params)
    if params.include?(:current_password)
      resource.update_with_password(params)
    else
      resource.update_without_password(params)
    end
  end
end
