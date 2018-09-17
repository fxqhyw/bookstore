class AddCoupon < Rectify::Command
  def initialize(code:, order:)
    @code = code
    @order = order
  end

  def call
    return broadcast(:invalid) unless find_coupon
    update_order
    broadcast(:ok)
  end

  private

  def find_coupon
    @coupon = Coupon.find_by_code(@code)
  end

  def update_order
    @order.update(coupon: @coupon)
  end
end
