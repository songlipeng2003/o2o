ActiveAdmin.register RefundBatch do
  menu parent: '财务'

  actions :index, :show

  scope :all, :default => true

  scope :applyed do |scope|
    scope.where(state: :applyed)
  end

  scope :finished do |scope|
    scope.where(state: :finished)
  end

  index do
    selectable_column
    id_column
    column :payment
    column :sn
    column :state do |refund_batch|
      refund_batch.aasm.human_state
    end
    column :created_at
    actions defaults: true do |refund_batch|
      link = ''
      link << link_to('处理', refund_batch.refund_link, target: '_blank') if refund_batch.applyed?
      link << ' ' if refund_batch.applyed?
      link << link_to('关闭', close_admin_refund_batch_path(refund_batch), method: :put,
        data: { confirm: '你确认要完成吗？' } ) if refund_batch.applyed?
      raw link
    end
  end

  member_action :close, method: :put do
    resource.close!
    redirect_to :back, notice: "关闭退款批次成功"
  end

  filter :payment
  filter :sn
  filter :state, as: :select, collection: PaymentRefundLog.aasm.states
  filter :created_at
end
