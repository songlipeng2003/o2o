class RechargePoliciesSystemCoupon < ActiveRecord::Base
  belongs_to :recharge_policy
  belongs_to :system_coupon
end
