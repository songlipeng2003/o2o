class Recharge < ActiveRecord::Base
  include AASM

  validates :user_id, presence: true
  validates :amount, presence: true
  validates_associated :recharge_policy

  belongs_to :user
  belongs_to :recharge_policy
  belongs_to :application

  has_many :payment_logs, as: :item
  has_one :payment_log, -> { order 'id DESC' }, as: :item

  before_validation :ensure_amount

  before_create :ensure_recharge_policy

  aasm column: :state do
    state :unpayed, :initial => true
    state :payed
    state :closed
    state :refunded

    event :pay do
      transitions from: :unpayed, to: :payed

      after do
        # 个人充值流水
        trading_record = TradingRecord.new
        trading_record.user = self.user
        trading_record.trading_type = TradingRecord::TRADING_TYPE_RECHARGE
        trading_record.object = self
        trading_record.amount = self.amount
        trading_record.name = "充值#{self.amount}元"
        trading_record.save

        if self.recharge_policy_id
          if self.recharge_policy.present_amount>0
            # 个人赠送流水
            trading_record = TradingRecord.new
            trading_record.user = self.user
            trading_record.trading_type = TradingRecord::TRADING_TYPE_PRESENT
            trading_record.object = self
            trading_record.name = "充值#{self.amount}元赠送#{self.recharge_policy.present_amount}元"
            trading_record.amount = self.recharge_policy.present_amount
            trading_record.save

            # 公司补贴流水
            trading_record = TradingRecord.new
            trading_record.user = SystemUser.company
            trading_record.trading_type = TradingRecord::TRADING_TYPE_SUBSIDY
            trading_record.object = self
            trading_record.name = "充值#{self.amount}元补贴#{self.recharge_policy.present_amount}元"
            trading_record.amount = -self.recharge_policy.present_amount
            trading_record.save
          end

          if self.recharge_policy.recharge_policies_system_coupons.length>0
            self.recharge_policy.recharge_policies_system_coupons.each do |recharge_policies_system_coupon|
              recharge_policies_system_coupon.number.times do
                coupon = Coupon.new
                coupon.user_id = self.user_id
                coupon.system_coupon_id = recharge_policies_system_coupon.system_coupon_id
                coupon.amount = recharge_policies_system_coupon.system_coupon.amount
                coupon.save
              end
            end
          end
        end

        self.payed_at = Time.now
      end
    end

    event :close do
      transitions from: :unpayed, to: :closed

      after do
        self.closed_at = Time.now

        if self.payment_log && self.payment_log.unpayed?
          self.payment_log.close
          self.payment_log.save
        end
      end
    end
  end

  def self.auto_close_expired_recharge
    self.where(state: 'unpayed').where("created_at<?", 1.hour.ago).find_each do |recharge|
      recharge.close
      recharge.save
    end
  end

  private
  def ensure_amount
    self.amount ||= recharge_policy.amount
  end

  def ensure_recharge_policy
    unless self.recharge_policy_id
      recharge_policy = RechargePolicy.where(amount: amount).first
      if recharge_policy
        self.recharge_policy_id = recharge_policy.id
        self.present_amount = recharge_policy.present_amount
      end
    end
  end
end
