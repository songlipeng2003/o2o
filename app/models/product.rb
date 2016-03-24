class Product < ActiveRecord::Base
  belongs_to :product_type
  belongs_to :category
  belongs_to :province, class_name: 'Area'
  belongs_to :city, class_name: 'Area'

  validates :name, presence: true
  validates :image, presence: true
  validates :province, presence: true
  validates :city, presence: true
  validates :price, presence: true, :numericality => { greater_than_or_equal_to: 0 }
  validates :description, presence: true
  validates :product_type, presence: true
  validates :market_price, presence: true, :numericality => { greater_than_or_equal_to: 0 }

  validates_associated :product_type
  validates_associated :category
  validates_associated :province
  validates_associated :city

  mount_uploader :image, ProductImageUploader

  default_scope -> { order('id DESC') }
end
