class RefundBatch < ActiveRecord::Base
  include AASM

  belongs_to :payment

  before_create :gen_sn

  before_create do
    self.payment_refund_logs.each do |payment_refund_log|
      payment_refund_log.operate
      payment_refund_log.save
    end
  end

  has_and_belongs_to_many :payment_refund_logs

  aasm column: :state do
    state :applyed, :initial => true
    state :finished
  end

  def refund_link
    options = {
      batch_no:  self.sn,
      data:       [],
      notify_url: 'http://24didi.com/pay/alipay_refund_notify'
    }
    self.payment_refund_logs.each do |payment_refund_log|
      options[:data] << {
        trade_no: payment_refund_log.payment_log.sn,
        amount:   payment_refund_log.amount,
        reason:   '退款'
      }
    end
    Alipay::Service.create_refund_url(options)
  end

  private
  def gen_sn
    sn = Alipay::Utils.generate_batch_no
    sn = gen_sn if Order.unscoped.where(sn: sn).first
    self.sn = sn
  end
end
