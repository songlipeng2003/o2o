class Recharge < ActiveRecord::Base
  include AASM

  validates :user_id, presence: true
  validates :amount, presence: true
  validates_associated :recharge_policy

  belongs_to :user
  belongs_to :recharge_policy
  belongs_to :application

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
        trading_record.save

        if self.recharge_policy_id
          if self.recharge_policy.present_amount>0
            trading_record = TradingRecord.new
            trading_record.user_id = self.user_id
            trading_record.trading_type = TradingRecord::TRADING_TYPE_PRESENT
            trading_record.object = self
            trading_record.amount = self.recharge_policy.present_amount
            trading_record.save
          end

          if self.recharge_policy.system_coupons.length>0
            self.recharge_policy.system_coupons.each do |system_coupon|
              coupon = Coupon.new
              coupon.user_id = self.user_id
              coupon.system_coupon_id = system_coupon.id
              coupon.amount = system_coupon.amount

              coupon.save
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
