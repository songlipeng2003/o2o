class Product < ActiveRecord::Base
  include ElasticsearchSearchable

  PRODUCT_TYPE_OUT_DOOR = 1;
  PRODUCT_TYPE_IN_DOOR = 2;

  PRODUCT_TYPES = {
    PRODUCT_TYPE_OUT_DOOR => '上门',
    PRODUCT_TYPE_IN_DOOR => '到店'
  }

  belongs_to :category
  belongs_to :province, class_name: 'Area'
  belongs_to :city, class_name: 'Area'
  belongs_to :system_product
  belongs_to :store

  has_many :service_areas

  validates :name, presence: true
  validates :image, presence: true
  validates :province, presence: true
  validates :city, presence: true
  validates :product_type, presence: true, inclusion: { in:  PRODUCT_TYPES.keys }
  validates :price, presence: true, :numericality => { greater_than_or_equal_to: 0 }
  validates :description, presence: true
  validates :market_price, presence: true, :numericality => { greater_than_or_equal_to: 0 }

  validates_associated :product_type
  validates_associated :category
  validates_associated :province
  validates_associated :city
  validates_associated :store

  mount_uploader :image, ProductImageUploader

  default_scope -> { order('id DESC') }


  # elasticsearch settings
  settings index: { number_of_shards: 1 } do
    mappings dynamic: 'strict' do
      indexes :name
      indexes :store_id
      indexes :product_type
      indexes :price
      indexes :market_price
      indexes :description
    end
  end

  def as_indexed_json(options={})
    self.as_json(only: [:name, :store_id, :product_type, :price, :market_price, :description])
  end

  def product_type_name
    PRODUCT_TYPES[product_type]
  end
end

# Product.import force: true
