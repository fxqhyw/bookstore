ActiveAdmin.register Order do
  permit_params :status

  scope :in_progress, default: true do |orders|
    orders.where.not(status: :delivered).where.not(status: :canceled)
  end

  scope :delivered do |orders|
    orders.where(status: :delivered)
  end

  scope :canceled do |orders|
    orders.where(status: :canceled)
  end

  filter :user, collection: User.pluck(:email, :id)
  filter :delivery
  filter :coupon, collection: Coupon.pluck(:code, :id)

  index do
    column :number
    column :user
    column :created_at
    column :status
    column do |order|
      link_to 'Change the status', edit_admin_order_path(order) unless order.in_progress?
    end
  end

  form title: 'Change the status' do |f|
    inputs 'Order details' do
      input :status, as: :select, collection: %w[in_delivery delivered canceled], include_blank: false
      h3 "Current status: #{f.order.status}"
    end
    actions
  end
end
