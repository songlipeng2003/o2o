class SystemCoupon < ActiveRecord::Base
  belongs_to :product

  validates :name, presence: true
  validates :image, presence: true
  validates :amount, presence: true, :numericality => { greater_than_or_equal_to: 0 }
  validates :description, presence: true

  # validates_associated :product

  has_one_attached :image
end
