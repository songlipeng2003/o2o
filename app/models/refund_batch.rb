class RefundBatch < ActiveRecord::Base
  include AASM
  include Snable

  belongs_to :payment
  has_and_belongs_to_many :payment_refund_logs

  before_create do
    self.payment_refund_logs.each do |payment_refund_log|
      payment_refund_log.operate
      payment_refund_log.save
    end
  end

  aasm column: :state do
    state :applyed, :initial => true
    state :finished
    state :closed

    event :finish do
      transitions from: :applyed, to: :finished
    end

    event :close do
      transitions from: :applyed, to: :closed

      after do
        self.payment_refund_logs.each do |payment_refund_log|
          payment_refund_log.release!
        end
      end
    end
  end

  def refund_link
    options = {
      batch_no:  self.sn,
      data:       [],
      notify_url: 'http://24didi.com/pay/alipay_refund_notify'
    }
    self.payment_refund_logs.each do |payment_refund_log|
      options[:data] << {
        trade_no: payment_refund_log.payment_log.out_trade_no,
        amount:   payment_refund_log.amount,
        reason:   '退款'
      }
    end
    Alipay::Service.create_refund_url(options)
  end

  def self.auto_close_expired
    self.where(state: 'applyed').where("created_at<?", Date.today).find_each do |refund_batch|
      refund_batch.close!
    end
  end
end
