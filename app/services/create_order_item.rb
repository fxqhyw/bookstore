class CreateOrderItem < Rectify::Command
  def initialize(order:, user:, params:)
    @order = order
    @user = user
    @params = params
  end

  def call
    create_order unless @order
    find_order_item
    update_order_item_quantity
    broadcast(:ok)
  end

  private

  def create_order
    return @order = @user.orders.create if @user

    @order = Order.create
    cookies.signed[:order_id] = { value: @order.id, expires: 1.month.from_now }
  end

  def find_order_item
    @order_item = @order.order_items.find_by(book_id: @params[:book_id])
  end

  def update_order_item_quantity
    return create_new_order_item unless @order_item

    @order_item.quantity += @params[:quantity].to_i
    @order_item.save
  end

  def create_new_order_item
    @order.order_items.create(@params)
  end
end
