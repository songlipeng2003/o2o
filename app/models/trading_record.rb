class TradingRecord < ActiveRecord::Base
  # 充值 +
  TRADING_TYPE_RECHARGE = 1

  # 消费 -
  TRADING_TYPE_EXPENSE = 2

  # 充值赠送 +
  TRADING_TYPE_PRESENT = 3

  # 退款 +
  TRADING_TYPE_RETURN = 4

  # 退款到银行 -
  TRADING_TYPE_RETURN_BANK = 5

  # 转入 + 针对平台
  TRADING_TYPE_IN = 6

  # 转出 - 针对平台
  TRADING_TYPE_OUT = 7

  # 补贴 - 针对公司
  TRADING_TYPE_SUBSIDY = 8

  # 退还补贴 + 针对公司
  TRADING_TYPE_RETURN_SUBSIDY = 9

  # 充值退款
  TRADING_TYPE_RECHARGE_RETURN = 10;

  # 赠送退款
  TRADING_TYPE_PRESENT_RETURN = 11;

  # 余额
  FUND_TYPE_BALANCE = 1

  # 冻结资金
  FUND_TYPE_FREEZE_BALANCE = 2

  TRADING_TYPES = {
    TRADING_TYPE_RECHARGE => '充值',
    TRADING_TYPE_EXPENSE => '消费',
    TRADING_TYPE_PRESENT => '赠送',
    TRADING_TYPE_RETURN => '退款',
    TRADING_TYPE_RETURN_BANK => '退款到银行',
    TRADING_TYPE_IN => '转入',
    TRADING_TYPE_OUT => '转出',
    TRADING_TYPE_SUBSIDY => '补贴',
    TRADING_TYPE_RETURN_SUBSIDY => '退款补贴',
    TRADING_TYPE_RECHARGE_RETURN => '充值退款'
  }

  FUND_TYPES = {
    FUND_TYPE_BALANCE => '余额',
    FUND_TYPE_FREEZE_BALANCE => '冻结资金'
  }

  belongs_to :finance
  belongs_to :object, polymorphic: true

  validates :finance, presence: true
  validates :amount, presence: true
  # validates :object, presence: true
  validates :trading_type, presence: true

  before_save :set_start_and_end

  after_save :change_balance

  def user
    finance.financeable if finance
  end

  def user=(user)
    self.finance = user.finance
  end

  def trading_type_name
    TRADING_TYPES[self.trading_type]
  end

  private
  def change_balance
    if fund_type==FUND_TYPE_BALANCE
      user.balance += amount
    else
      user.freeze_balance += amount
    end

    user.save
  end

  def set_start_and_end
    self.start_amount = user.total_balance
    self.end_amount = user.total_balance + self.amount
  end
end
