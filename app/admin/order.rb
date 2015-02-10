ActiveAdmin.register Order do
  menu parent: '订单'

  actions :index, :show

  scope :all, :default => true

  scope :unpayed do
    Order.where(state: :unpayed)
  end

  scope :payed do
    Order.where(state: :payed)
  end

  scope :finished do
    Order.where(state: :finished)
  end

  scope :closed do
    Order.where(state: :closed)
  end

  index do
    selectable_column
    id_column
    column :user
    column :store
    column :car
    column :phone
    column :address
    column :booked_at
    column :state do |order|
      order.aasm.human_state
    end
    column :created_at
    actions defaults: true do |order|
      link_to '关闭', close_admin_order_path(order),
        method: :put,
        data: { confirm: '你确认要关闭吗？' } if order.payed?
    end
  end

  filter :phone
  filter :address
  filter :booked_at
  filter :created_at

  member_action :close, method: :put do
    resource.admin_close
    resource.save
    redirect_to :back, notice: "关闭成功"
  end

  action_item :close, only: :show do
    link_to '关闭', close_admin_order_path(order),
      method: :put,
      data: { confirm: '你确认要关闭吗？' } if order.payed?
  end
end
