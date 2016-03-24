class PaymentLog < ActiveRecord::Base
  include AASM
  include Snable

  attr_accessor :extras

  belongs_to :item, polymorphic: true
  belongs_to :payment
  belongs_to :application

  validates :item, presence: true
  validates :payment, presence: true

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
        if item_type=='Recharge'
          trading_record = TradingRecord.new
          trading_record.user = self.item.user
          trading_record.trading_type = TradingRecord::TRADING_TYPE_RECHARGE_RETURN
          trading_record.object = self.item
          trading_record.name = self.name
          trading_record.amount = - self.amount
          trading_record.save

          if self.item.present_amount && self.item.present_amount>0
            trading_record = TradingRecord.new
            trading_record.user = self.item.user
            trading_record.trading_type = TradingRecord::TRADING_TYPE_PRESENT_RETURN
            trading_record.object = self.item
            trading_record.name = self.name
            trading_record.amount = - self.item.present_amount
            trading_record.save


            trading_record = TradingRecord.new
            trading_record.user = SystemUser.company
            trading_record.trading_type = TradingRecord::TRADING_TYPE_RETURN_SUBSIDY
            trading_record.object = self.item
            trading_record.name = self.name
            trading_record.amount = - self.item.present_amount
            trading_record.save
          end
        else
          trading_record = TradingRecord.new
          trading_record.user = self.item.user
          trading_record.trading_type = TradingRecord::TRADING_TYPE_RETURN
          trading_record.object = self.item
          trading_record.name = self.name
          trading_record.amount = self.amount
          trading_record.fund_type = TradingRecord::FUND_TYPE_FREEZE_BALANCE unless payment.balance?
          trading_record.save
        end

        payment_refund_log = PaymentRefundLog.new
        payment_refund_log.payment_log = self
        payment_refund_log.payment = payment
        payment_refund_log.amount = self.amount
        payment_refund_log.out_trade_no = self.out_trade_no

        if pingxx
          charge = Pingpp::Charge.retrieve(pingxx)
          refund = charge.refunds.create description: '退款'
          payment_refund_log.pingxx = refund.id
        end

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
end
