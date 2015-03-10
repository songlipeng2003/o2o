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

  def ensure_amount
    self.amount ||= recharge_policy.amount
  end

  aasm column: :state do
    state :unpayed, :initial => true
    state :payed
    state :failed

    event :pay do
      transitions :from => :unpayed, :to => :payed

      after do
        trading_record = TradingRecord.new
        trading_record.user_id = self.user_id
        trading_record.trading_type = TradingRecord::TRADING_TYPE_RECHARGE
        trading_record.object = self
        trading_record.amount = self.amount
        trading_record.name = "充值#{self.amount}元"
        trading_record.save

        if self.recharge_policy_id
          if self.recharge_policy.present_amount>0
            trading_record = TradingRecord.new
            trading_record.user_id = self.user_id
            trading_record.trading_type = TradingRecord::TRADING_TYPE_PRESENT
            trading_record.object = self
            trading_record.name = "充值#{self.amount}元赠送#{self.present_amount}元"
            trading_record.amount = self.recharge_policy.present_amount
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

    event :fail do
      transitions :from => :unpayed, :to => :failed
    end
  end
end
