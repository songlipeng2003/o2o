class Product < ActiveRecord::Base
  PRODUCT_TYPE_WASH = 1
  PRODUCT_TYPE_WAX = 2
  PRODUCT_TYPE_POLISHING = 3
  PRODUCT_TYPE_DEEP_CLEAN = 4;

  PRODUCT_TYPES = {
    PRODUCT_TYPE_WASH => '标准洗车',
    PRODUCT_TYPE_WAX => '标准打蜡',
    PRODUCT_TYPE_POLISHING => '标准抛光',
    PRODUCT_TYPE_DEEP_CLEAN => '标准深清'
  }

  validates :name, presence: true
  validates :image, presence: true
  validates :price, presence: true, :numericality => { greater_than_or_equal_to: 0 }
  validates :description, presence: true
  validates :product_type, presence: true
  validates :market_price, presence: true, :numericality => { greater_than_or_equal_to: 0 }

  mount_uploader :image, ProductImageUploader
end
