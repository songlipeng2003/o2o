class Product < ActiveRecord::Base
  PRODUCT_TYPE_WASH = 1
  PRODUCT_TYPE_WAX = 2

  PRODUCT_TYPES = {
    PRODUCT_TYPE_WASH => '标准洗车',
    PRODUCT_TYPE_WAX => '标准打蜡'
  }

  validates :name, presence: true
  validates :price, presence: true, :numericality => { greater_than_or_equal_to: 0 }
  validates :description, presence: true
  validates :product_type, presence: true
end
