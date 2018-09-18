class CheckoutsController < ApplicationController
  include Wicked::Wizard
  include CheckoutUpdater

  before_action :authenticate_user!, only: :update

  steps :login, :address, :delivery, :payment, :confirm

  def show
    CheckoutStepper.call(steps: steps, current_step: step, edit: params[:edit]) do
      on(:empty_cart) { redirect_to cart_path, alert: I18n.t('notice.empty_cart') }
      on(:ok) { render_wizard }
    end
  end

  def update
    case step
    when :address then update_addresses
    when :delivery then update_delivery
    when :payment then update_credit_card
    when :confirm then confirm_order
    end
  end
end
