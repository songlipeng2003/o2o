class Product < ActiveRecord::Base
  belongs_to :product_type

  validates :name, presence: true
  validates :image, presence: true
  validates :price, presence: true, :numericality => { greater_than_or_equal_to: 0 }
  validates :description, presence: true
  validates :product_type, presence: true
  validates :market_price, presence: true, :numericality => { greater_than_or_equal_to: 0 }

  validates_associated :product_type

  mount_uploader :image, ProductImageUploader

  default_scope -> { order('id DESC') }
end
