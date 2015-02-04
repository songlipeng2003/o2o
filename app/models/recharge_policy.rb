class RechargePolicy < ActiveRecord::Base
  validates :amount, presence: true, :numericality => { :only_integer => true, greater_than: 0 }
  validates :present_amount, presence: true, :numericality => { :only_integer => true, greater_than_or_equal_to: 0 }

  validates :note, presence: true

  has_and_belongs_to_many :system_coupons

  has_paper_trail
end
