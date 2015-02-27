class SystemCoupon < ActiveRecord::Base
  belongs_to :product
  belongs_to :product_type

  validates :name, presence: true
  validates :image, presence: true
  validates :amount, presence: true, :numericality => { greater_than_or_equal_to: 0 }
  validates :description, presence: true

  validates_associated :product
  validates_associated :product_type

  mount_uploader :image, SystemCouponImageUploader
end
