class TradingRecord < ActiveRecord::Base
  TRADING_TYPE_RECHARGE = 1
  TRADING_TYPE_EXPENSE = 2
  TRADING_TYPE_PRESENT = 3
  TRADING_TYPE_RETURN = 4
  TRADING_TYPE_RETURN_BANK = 5

  TRADING_TYPES = {
    TRADING_TYPE_RECHARGE => '充值',
    TRADING_TYPE_EXPENSE => '消费',
    TRADING_TYPE_PRESENT => '赠送',
    TRADING_TYPE_RETURN => '退款',
    TRADING_TYPE_RETURN_BANK => '退款到银行'
  }

  belongs_to :user
  belongs_to :object, polymorphic: true

  validates :user_id, presence: true
  validates :amount, presence: true
  validates :object, presence: true
  validates :trading_type, presence: true

  after_save :change_balance

  def trading_type_name
    TRADING_TYPES[self.trading_type]
  end

  def change_balance
    user.balance += amount
    user.save
  end
end
