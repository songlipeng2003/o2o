class PaymentLog < ActiveRecord::Base
  include AASM

  belongs_to :item, polymorphic: true
  belongs_to :payment
  belongs_to :application

  validates :item, presence: true
  validates :payment, presence: true

  before_create :gen_sn

  aasm column: :state do
    state :unpayed, :initial => true
    state :payed
    state :closed
    state :refunded

    event :pay do
      transitions :from => :unpayed, :to => :payed

      after do
        self.payed_at = Time.now

        item = self.item
        item.pay!(item.user)
      end
    end

    event :close do
      transitions :from => :unpayed, :to => :closed

      after do
        self.closed_at = Time.now

        if self.payment.payment_type=='alipay' && self.out_trade_no
          Alipay::Service.close_trade(
            :trade_no     => self.out_trade_no,
            :out_order_no => self.sn
          )
        end
      end
    end

    event :refund do
      transitions :from => :payed, :to => :refunded

      after do
        trading_record = TradingRecord.new
        trading_record.user_id = self.item.user_id
        trading_record.trading_type = TradingRecord::TRADING_TYPE_RETURN
        trading_record.object = self.item
        trading_record.name = self.name
        trading_record.amount = self.amount
        trading_record.save

        payment_refund_log = PaymentRefundLog.new
        payment_refund_log.payment_log = self
        payment_refund_log.payment = payment
        payment_refund_log.amount = self.amount
        payment_refund_log.out_trade_no = self.out_trade_no
        payment_refund_log.save
      end
    end
  end

  after_create :close_order_other_payments

  private

  def close_order_other_payments
    self.item.payment_logs.where(state: :unpayed).where.not(id: self.id).each do |payment_log|
      payment_log.close!
    end
  end

  def gen_sn
    sn = Time.now.strftime('%Y%m%d') + rand(100000...999999).to_s
    sn = gen_sn if Order.unscoped.where(sn: sn).first
    self.sn = sn
  end
end
