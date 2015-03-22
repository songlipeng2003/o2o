class Product < ActiveRecord::Base
  PRODUCT_TYPE_OUT_DOOR = 1;
  PRODUCT_TYPE_IN_DOOR = 2;

  PRODUCT_TYPES = {
    PRODUCT_TYPE_OUT_DOOR => '上门',
    PRODUCT_TYPE_IN_DOOR => '到店'
  }

  belongs_to :category
  belongs_to :system_product

  validates :name, presence: true
  validates :image, presence: true
  validates :product_type, presence: true, inclusion: { in:  PRODUCT_TYPES.keys }
  validates :price, presence: true, :numericality => { greater_than_or_equal_to: 0 }
  validates :description, presence: true
  validates :market_price, presence: true, :numericality => { greater_than_or_equal_to: 0 }

  validates_associated :category

  mount_uploader :image, ProductImageUploader

  default_scope -> { order('id DESC') }

  def product_type_name
    PRODUCT_TYPES[product_type]
  end
end
