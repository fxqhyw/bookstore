class CheckoutStep
  def initialize(order:, steps:, current_step:, edit: false)
    @order = order
    @steps = steps
    @current_step = current_step
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
    when :address
      #@order.addresses.try(:persisted?)
      true
    when :delivery
      #@order.delivery
      true
    when :payment
      @order.credit_card
    when :confirm
      @order.in_queue?
    end
  end
end
