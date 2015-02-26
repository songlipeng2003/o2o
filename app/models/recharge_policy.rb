class RechargePolicy < ActiveRecord::Base
  validates :amount, presence: true, :numericality => { :only_integer => true, greater_than: 0 }
  validates :present_amount, presence: true, :numericality => { :only_integer => true, greater_than_or_equal_to: 0 }
  validates :sort, presence: true, :numericality => { :only_integer => true, greater_than_or_equal_to: 0 }

  validates :note, presence: true

  has_many :recharge_policies_system_coupons, dependent: :destroy
  has_many :system_coupons, through: :recharge_policies_system_coupons

  accepts_nested_attributes_for :recharge_policies_system_coupons, reject_if: :all_blank, allow_destroy: true

  default_scope -> { order('sort DESC, id DESC') }

  default_value_for :sort, '0'

  has_paper_trail
end
