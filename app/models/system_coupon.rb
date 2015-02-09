class SystemCoupon < ActiveRecord::Base
  belongs_to :product

  validates :name, presence: true
  validates :product, presence: true
  validates :amount, presence: true, :numericality => { greater_than_or_equal_to: 0 }
  validates :description, presence: true
end
