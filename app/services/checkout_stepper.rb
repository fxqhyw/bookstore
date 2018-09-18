class CheckoutStepper < Rectify::Command
  def initialize(steps:, current_step:, edit: false)
    @steps = steps
    @current_step = current_step
    @editable = edit
  end

  def call
    return broadcast(:empty_cart) if empty_cart?

    showable_step
    jump_to(@step) unless @current_step == @step
    broadcast(:ok)
  end

  private

  def showable_step
    if @editable && completed?(@current_step)
      @step = @current_step
    else
      @steps.reverse_each do |step|
        @step = step unless completed?(step)
      end
    end
  end

  def completed?(step)
    {
      login: user_signed_in?,
      address: current_order.billing_address,
      delivery: current_order.delivery,
      payment: current_order.credit_card,
      confirm: current_order.in_queue?
    }[step]
  end

  def empty_cart?
    return true unless current_order

    current_order.order_items.empty?
  end
end
