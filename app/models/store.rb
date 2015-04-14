class Store < ActiveRecord::Base
  include Financeable
  include ElasticsearchSearchable

  STORE_TYPE_SELF = 1
  STORE_TYPE_JOIN = 2

  STORE_TYPES ={
    STORE_TYPE_SELF => '自营',
    STORE_TYPE_JOIN => '加盟'
  }

  belongs_to :province, class_name: 'Area'
  belongs_to :city, class_name: 'Area'
  belongs_to :area, class_name: 'Area'

  validates :name, presence: true, uniqueness: true
  validates :address, presence: true
  validates :phone, presence: true
  validates :description, presence: true
  validates :lon, presence: true, numericality: true
  validates :lat, presence: true, numericality: true
  validates :province, presence: true
  validates :city, presence: true
  validates :area, presence: true
  validates :store_type, presence: true

  validates_associated :province
  validates_associated :city
  validates_associated :area

  has_many :store_users
  has_many :orders
  has_many :products
  has_many :service_areas, through: :products

  before_create do
    update_area_info
  end

  def store_type_name
    STORE_TYPES[store_type]
  end

  def location
    [lat, lon]
  end

  def system_product_ids
    products.map { |product| product.system_product_id  }
  end

  # elasticsearch settings
  settings index: { number_of_shards: 1 } do
    mappings dynamic: 'strict' do
      indexes :id
      indexes :store_type
      indexes :name
      indexes :phone
      indexes :address
      indexes :phone
      indexes :description
      indexes :location, type: 'geo_point', geohash_precision: '1m'
    end
  end

  def as_indexed_json(options={})
    self.as_json(only: [:id, :store_type, :name, :phone, :address, :phone, :description], method: [:location])
  end

  private
  def update_area_info
    if self.area_id
      area = Area.find(self.area_id)
      self.city_id = area.parent.id
      self.province_id = area.parent.parent.id
    end
  end
end

Store.import force: true
