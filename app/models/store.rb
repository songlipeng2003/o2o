class Store < ActiveRecord::Base
  include Financeable
  include ElasticsearchSearchable

  STORE_TYPE_SELF = 1
  STORE_TYPE_JOIN = 2

  STORE_TYPES = {
    STORE_TYPE_SELF => '自营',
    STORE_TYPE_JOIN => '加盟'
  }

  belongs_to :province, class_name: 'Area'
  belongs_to :city, class_name: 'Area'
  belongs_to :area, class_name: 'Area'

  has_many :store_users
  has_many :orders
  has_many :evaluations

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

  acts_as_paranoid

  before_create do
    update_area_info
  end

  def store_type_name
    STORE_TYPES[store_type]
  end

  # 是否在服务范围内
  def self.in_service_scope(lon, lat)
    query = {
      query:{
        filtered: {
          query: {
            match_all: {}
          },
          filter: {
            geo_shape: {
              service_area_location: {
                relation: "intersects",
                shape: {
                  type: 'point',
                  coordinates: [lon.to_f, lat.to_f]
                }
              }
            }
          }
        }
      }
    }

    logger.debug query.to_yaml

    __elasticsearch__.search(query)
  end

  def self.can_serviced(lon, lat, booked_at)
    stores = in_service_scope(lon, lat)
    stores.each do |store|
      store = Store.find(store.id)
      if Order.unscoped.where({ store_id: store.id, booked_at: booked_at }).where.not(state: 'closed').count < store.store_users.count
        return true
      end
    end
    false
  end

  def self.can_serviced_in_night(lon, lat, booked_at)
    stores = in_service_scope(lon, lat)
    stores.each do |store|
      store = Store.find(store.id)
      if Order.unscoped.where({ store_id: store.id, booked_at: booked_at }).where.not(state: 'closed').count < store.store_users.count * 16
        return true
      end
    end
    false
  end

  def self.can_serviced_store(lon, lat, booked_at)
    stores = in_service_scope(lon, lat)
    stores.each do |store|
      store = Store.find(store.id)
      store_users_ids = store.store_users.map do |store_user|
        store_user.id
      end

      store_users_ids.shuffle!

      count = Order.unscoped.where({ store_id: store.id, booked_at: booked_at }).where.not(state: 'closed').count

      if count < store.store_users.count
        store_users_ids.each do |store_user_id|
          count = Order.unscoped.where({ store_user_id: store_user_id, booked_at: booked_at }).where.not(state: 'closed').count

          return store_user_id if count==0
        end
      end
    end
    false
  end

  def self.can_serviced_store_in_night(lon, lat, booked_at)
    stores = in_service_scope(lon, lat)
    stores.each do |store|
      store = Store.find(store.id)
      store_users_ids = store.store_users.map do |store_user|
        store_user.id
      end

      store_users_ids.shuffle!

      count = Order.unscoped.where({ store_id: store.id, booked_at: booked_at }).where.not(state: 'closed').count

      if count < store.store_users.count * 16
        store_users_ids.each do |store_user_id|
          count = Order.unscoped.where({ store_user_id: store_user_id, booked_at: booked_at }).where.not(state: 'closed').count

          return store_user_id if count<16
        end
      end
    end
    false
  end

  include ElasticsearchSearchable

  def service_area_location
    coordinates = self.service_area.split(',')
    coordinates = (0..coordinates.length-1).step(2).map do |i|
      [coordinates[i].to_f, coordinates[i+1].to_f]
    end

    coordinates << coordinates[0]

    {
      type: 'polygon',
      coordinates: [coordinates]
    }
  end

  def location
    [lat, lon]
  end

  def system_product_ids
    products.map { |product| product.system_product_id  }
  end

  # elasticsearch settings
  settings index: { number_of_shards: 5 } do
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
# Store.import force: true
