ActiveAdmin.register Order do
  menu parent: '订单'

  actions :index, :show

  scope '所有', :all, default: true

  scope :unpayed do |scope|
    scope.where(state: :unpayed)
  end

  scope :payed do |scope|
    scope.where(state: :payed)
  end

  scope :finished do |scope|
    scope.where(state: :finished)
  end

  scope :closed do |scope|
    scope.where(state: :closed)
  end

  index do
    selectable_column
    id_column
    column :sn
    column :user
    column :store
    column :total_amount
    column :product
    column :booked_at
    column :state do |order|
      order.aasm.human_state
    end
    column :application
    column :created_at
    actions defaults: true do |order|
      link = ''
      link << link_to('关闭', close_admin_order_path(order),
        method: :put,
        data: { confirm: '你确认要关闭吗？' }) if order.payed?
      link << ' '
      link << link_to('完成', finish_admin_order_path(order),
        method: :put,
        data: { confirm: '你确认要完成吗？' }) if order.payed?

      raw link
    end
  end

  filter :sn
  filter :phone
  filter :license_tag
  filter :place
  filter :product
  filter :state
  filter :booked_at
  filter :created_at

  member_action :close, method: :put do
    resource.admin_close! current_admin_user
    redirect_to :back, notice: "关闭订单成功"
  end

  member_action :finish, method: :put do
    resource.finish! current_admin_user
    redirect_to :back, notice: "完成订单成功"
  end

  action_item :close, only: :show do
    link_to '关闭', close_admin_order_path(order),
      method: :put,
      data: { confirm: '你确认要关闭吗？' } if order.payed?
  end

  action_item :finish, only: :show do
    link_to '完成', finish_admin_order_path(order),
      method: :put,
      data: { confirm: '你确认要完成吗？' } if order.payed?
  end

  controller do
    def scoped_collection
      Order.unscoped
    end
  end
end
