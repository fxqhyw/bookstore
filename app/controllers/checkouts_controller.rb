class CheckoutsController < ApplicationController
  include Wicked::Wizard
  include CheckoutUpdater

  before_action :authenticate_user!, only: :update

  steps :login, :address, :delivery, :payment, :confirm

  def show
    return redirect_to cart_path, alert: I18n.t('notice.empty_cart') if empty_cart?
    showable_step = CheckoutStepper.new(steps: steps, current_step: step, order: @current_order,
                                        edit: params[:edit], user: current_user).call
    jump_to(showable_step) unless step == showable_step
    render_wizard
  end

  def update
    case step
    when :address then update_addresses
    when :delivery then update_delivery
    when :payment then update_credit_card
    when :confirm then confirm_order
    end
  end

  private

  def empty_cart?
    return true unless @current_order
    @current_order.order_items.empty?
  end
end
