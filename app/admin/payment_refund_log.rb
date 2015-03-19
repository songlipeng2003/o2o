ActiveAdmin.register PaymentRefundLog do
  menu parent: '财务'

  actions :index, :show

  scope :all, :default => true

  scope :applyed do |scope|
    scope.where(state: :applyed)
  end

  scope :operated do |scope|
    scope.where(state: :operated)
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
    column :payment
    column :payment_log
    column :state do |payment_refund_log|
      payment_refund_log.aasm.human_state
    end
    column :created_at
    actions
  end

  filter :payment
  filter :amount
  filter :state, as: :select, collection: PaymentRefundLog.aasm.states
  filter :created_at

  batch_action :alipay_refund do |ids|
    payment_refund_logs = ids.map do |id|
      PaymentRefundLog.find(id)
    end
    refund_batch = RefundBatch.new
    refund_batch.payment_refund_logs = payment_refund_logs
    refund_batch.payment = PaymentRefundLog.find(ids[0]).payment
    refund_batch.save

    url = refund_batch.refund_link
    redirect_to url
  end
end
