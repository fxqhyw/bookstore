class CheckoutSteps
  def initialize(order:, steps:)
    @order = order
    @steps = steps
  end

  def call
    @steps.reverse_each do |step|
      @step = step unless completed?(step)
    end
    @step
  end

  private

  def completed?(step)
    case step
    when :address
      @order.addresses.first
    when :delivery
      @order.delivery
    when :payment
      @order.credit_card
    when :confirm
      @order.in_queue?
    end
  end
end
