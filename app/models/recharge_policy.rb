class RechargePolicy < ActiveRecord::Base
  validates :amount, presence: true, :numericality => { :only_integer => true, greater_than: 0 }
  validates :present_amount, presence: true, :numericality => { :only_integer => true, greater_than: 0 }

  has_paper_trail
end
