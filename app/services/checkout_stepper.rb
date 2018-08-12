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
    @steps.reverse_each do |step|
      @step = step unless completed?(step)
    end
    @step
  end

  private

  def completed?(step)
    case step
    when :login
      @user
    when :address
      @order.billing_address
    when :delivery
      #@order.delivery
    when :payment
      @order.credit_card
    when :confirm
      @order.in_queue?
    end
  end
end
