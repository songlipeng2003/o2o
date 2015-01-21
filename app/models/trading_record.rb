class TradingRecord < ActiveRecord::Base
  TRADING_TYPE_RECHARGE = 1;
  TRADING_TYPE_EXPENSE = 2;
  TRADING_TYPE_PRESENT = 3;

  TRADING_TYPES = {
    TRADING_TYPE_RECHARGE => '充值',
    TRADING_TYPE_EXPENSE => '消费',
    TRADING_TYPE_PRESENT => '赠送'
  }

  belongs_to :user
  belongs_to :object, polymorphic: true

  validates :user_id, presence: true
  validates :type, presence: true
  validates :amount, presence: true
  validates :object, presence: true
  validates :trading_type, presence: true

  def trading_type_name
    TRADING_TYPES[self.trading_type]
  end
end
