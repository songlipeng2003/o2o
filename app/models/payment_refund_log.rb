class PaymentRefundLog < ActiveRecord::Base
  include AASM
  include Snable

  belongs_to :payment
  belongs_to :payment_log

  after_create do
    if self.payment.code == 'balance'
      self.finish
      self.save
    end
  end

  aasm column: :state do
    state :applyed, :initial => true
    state :operated
    state :finished
    state :closed

    event :operate do
      transitions :from => :applyed, :to => :operated
    end

    event :finish do
      transitions :from => [:applyed, :operated], :to => :finished

      after do
        unless self.payment.code == 'balance'
          trading_record = TradingRecord.new
          trading_record.user = self.payment_log.item
          trading_record.trading_type = TradingRecord::TRADING_TYPE_RETURN_BANK
          trading_record.object = self.item
          trading_record.name = self.name
          trading_record.amount = -self.amount
          trading_record.save
        end
      end
    end
  end
end
