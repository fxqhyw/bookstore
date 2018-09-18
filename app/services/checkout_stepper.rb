class CheckoutStepper
  def initialize(order:, steps:, current_step:, user:, edit: false)
    @order = order
    @steps = steps
    @current_step = current_step
    @user = user
    @editable = edit
  end

  def call
    return @current_step if @editable && completed?(@current_step)

    @steps.each do |step|
      return @step = step unless completed?(step)
    end
    @step
  end

  private

  def completed?(step)
    {
      login: @user,
      address: @order.billing_address,
      delivery: @order.delivery,
      payment: @order.credit_card,
      confirm: @order.in_queue?
    }[step]
  end
end
