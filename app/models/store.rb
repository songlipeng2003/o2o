class Store < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  validates :address, presence: true
  validates :phone, presence: true
  validates :description, presence: true
  validates :lon, presence: true, numericality: true
  validates :lat, presence: true, numericality: true

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
                  coordinates: [lon, lat]
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
    ids = stores.map { |store| store._id }
    if ids.count>0
      count = Order.where({ store_id: ids, booked_at:booked_at }).count
      logger.info(count)
      count<ids.count
    else
      false
    end
  end

  include ElasticsearchSearchable

  def service_area_location
    coordinates = self.service_area.split(',')
    coordinates = (0..coordinates.length-1).step(2).map do |i|
      [coordinates[i], coordinates[i+1]]
    end

    {
      type: 'polygon',
      coordinates: [coordinates]
    }
  end

  # elasticsearch settings
  settings index: { number_of_shards: 1 } do
    mappings dynamic: 'strict' do
      indexes :name
      indexes :address
      indexes :phone
      indexes :description
      indexes :service_area_location, type: 'geo_shape', tree: 'geohash', precision: '1m'
    end
  end

  def as_indexed_json(options={})
    self.as_json(only: [:name, :address, :phone, :description], methods: :service_area_location)
  end
end

Store.import force: true
