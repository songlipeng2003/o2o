class Product < ActiveRecord::Base
  belongs_to :category
  belongs_to :system_product

  validates :name, presence: true
  validates :image, presence: true
  validates :price, presence: true, :numericality => { greater_than_or_equal_to: 0 }
  validates :description, presence: true
  validates :market_price, presence: true, :numericality => { greater_than_or_equal_to: 0 }

  validates_associated :category

  mount_uploader :image, ProductImageUploader

  default_scope -> { order('id DESC') }
end
