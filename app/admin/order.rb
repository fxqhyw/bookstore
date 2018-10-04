ActiveAdmin.register Order do
  permit_params :status

  actions :index, :show, :edit, :update, :destroy

  users = proc { User.pluck(:email, :id) }
  coupons = proc { Coupon.pluck(:code, :id) }

  scope :in_progress, default: true do |orders|
    orders.where.not(status: :delivered).where.not(status: :canceled)
  end

  scope :delivered do |orders|
    orders.where(status: :delivered)
  end

  scope :canceled do |orders|
    orders.where(status: :canceled)
  end

  filter :user, collection: users
  filter :delivery
  filter :coupon, collection: coupons

  index do
    selectable_column
    column :number
    column :user
    column :created_at
    column :status
    column do |order|
      link_to I18n.t('admin.change_status'), edit_admin_order_path(order) unless order.in_progress?
    end
  end

  form title: I18n.t('admin.change_status') do |f|
    inputs I18n.t('admin.order_details') do
      input :status, as: :select, collection: %w[in_delivery delivered canceled], include_blank: false
      h3 I18n.t('admin.current_status') + f.order.status
    end
    actions
  end
end
