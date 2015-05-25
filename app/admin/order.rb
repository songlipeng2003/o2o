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

  scope :deleted do |scope|
    scope.only_deleted
  end

  index do
    selectable_column
    column :sn
    column :user
    column :store
    column :store_user
    column :total_amount
    column :product
    column :car do |order|
      order.car_model.name
    end
    column :license_tag
    column :place
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

      link << link_to('切换店铺用户', change_store_user_admin_order_path(order)) if order.payed?

      raw link
    end
  end

  filter :sn
  filter :phone
  filter :license_tag
  filter :place
  filter :product
  filter :state
  filter :application
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

  member_action :change_store_user, method: [:get, :put, :patch] do
    @order = Order::find(params[:id])

    if request.put? || request.patch?
      @order.change_store_user!(params[:order][:store_user_id])

      redirect_to admin_order_path, notice: "修改商户成功"
    else
      @page_title = "修改商户"
    end
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

  batch_action :finish, confirm: '你确认要完成这些订单吗？' do |ids|
    orders = ids.map do |id|
      order = Order.with_deleted.find(id)
      order.finish! current_admin_user if order.payed?
    end

    redirect_to :back, notice: "完成订单成功"
  end

  batch_action :close, confirm: '你确认要关闭这些订单吗？' do |ids|
    orders = ids.map do |id|
      order = Order.find(id)
      order.admin_close! current_admin_user if order.payed?
    end

    redirect_to :back, notice: "完成订单成功"
  end

  controller do
    def scoped_collection
      Order.with_deleted
    end
  end
end
