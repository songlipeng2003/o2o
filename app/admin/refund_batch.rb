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
    actions defaults: true do |order|
      link_to '处理', order.refund_link, target: '_blank'
    end
  end

  filter :payment
  filter :sn
  filter :state, as: :select, collection: PaymentRefundLog.aasm.states
  filter :created_at
end
