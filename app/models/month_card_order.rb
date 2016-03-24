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

    event :pay do
      transitions :from => :unpayed, :to => :payed

      after do
        if payment_log.payment.code != 'balance'
          trading_record = TradingRecord.new
          trading_record.user = self.user
          trading_record.trading_type = TradingRecord::TRADING_TYPE_RECHARGE
          trading_record.object = self
          trading_record.amount = self.price
          trading_record.name = "充值#{trading_record.amount}"
          trading_record.save!
        end

        trading_record = TradingRecord.new
        trading_record.user = self.user
        trading_record.trading_type = TradingRecord::TRADING_TYPE_EXPENSE
        trading_record.object = self
        trading_record.name = "#{self.month}个月消费卡"
        trading_record.amount = -self.price
        trading_record.save!

        trading_record = TradingRecord.new
        trading_record.user = SystemUser.platform
        trading_record.trading_type = TradingRecord::TRADING_TYPE_IN
        trading_record.object = self
        trading_record.name = "#{self.month}个月消费卡"
        trading_record.amount = self.price
        trading_record.save!

        history_month_card = self.user.month_cards.where(license_tag: self.license_tag, state: 'available')
          .where("expired_at>?", Time.now).order('id DESC').first

        month_card = self.user.month_cards.new
        month_card.car_id = car_id
        month_card.name = system_month_card.name
        month_card.license_tag = license_tag
        month_card.application = application
        month_card.started_at = history_month_card ? history_month_card.expired_at : Time.now
        month_card.expired_at = month_card.started_at + month.months

        month_card.save!
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

  def car_id=(car_id)
    super(car_id)

    self.license_tag = self.car.license_tag
  end

  def system_month_card_id=(system_month_card_id)
    super(system_month_card_id)

    self.month = self.system_month_card.month
    self.price = self.system_month_card.price
  end
end
