class MonthCardOrder < ActiveRecord::Base
  include AASM

  belongs_to :user
  belongs_to :system_month_card
  belongs_to :car
  belongs_to :application

  has_many :payment_logs, as: :item
  has_one :payment_log, -> { order 'id DESC' }, as: :item

  has_paper_trail

  aasm column: :state do
    state :unpayed, :initial => true
    state :payed
    state :closed

    event :pay, after: :log_state_change do
      after do
        if payment_log.payment.code != 'balance'
          trading_record = TradingRecord.new
          trading_record.user = self.user
          trading_record.trading_type = TradingRecord::TRADING_TYPE_RECHARGE
          trading_record.object = self
          trading_record.amount = self.total_amount
          trading_record.name = "充值#{trading_record.amount}"
          trading_record.save
        end

        trading_record = TradingRecord.new
        trading_record.user = self.user
        trading_record.trading_type = TradingRecord::TRADING_TYPE_EXPENSE
        trading_record.object = self
        trading_record.name = self.product.name
        trading_record.amount = -self.total_amount
        trading_record.save

        trading_record = TradingRecord.new
        trading_record.user = SystemUser.platform
        trading_record.trading_type = TradingRecord::TRADING_TYPE_IN
        trading_record.object = self
        trading_record.name = self.product.name
        trading_record.amount = self.total_amount
        trading_record.save
      end
    end

    event :close do
      transitions :from => :unpayed, :to => :closed

      after do
        if self.payment_log && self.payment_log.unpayed?
          self.payment_log.close!
        end
      end
    end
  end

  def self.auto_close_expired_order
    self.where(state: 'unpayed').where("created_at<?", 30.minutes.ago).find_each do |order|
      order.close!
    end
  end

  def system_month_card_id=(system_month_card_id)
    super(system_month_card_id)

    self.month = self.system_month_card.month
    self.price = self.system_month_card.price
  end
end
