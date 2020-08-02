class StoreUserServiceArea < ActiveRecord::Base
  include ElasticsearchSearchable

  belongs_to :store_user
  belongs_to :service_area

  # elasticsearch settings
  settings index: { number_of_shards: 1 } do
    mappings dynamic: 'strict' do
      indexes :store_id
      indexes :store_user_id
      indexes :product_id
      indexes :areas, type: 'geo_shape', tree: 'geohash', precision: '1m'
    end
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
              areas: {
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
    store_user_service_areas = in_service_scope(lon, lat)
    ids = store_user_service_areas.map { |store_user_service_area| store_user_service_area.store_user_id }

    return Order.unscoped.where({ store_user_id: ids, booked_at: booked_at }).count < ids.length
  end

  def self.can_serviced_store(lon, lat, booked_at)
    store_user_service_areas = in_service_scope(lon, lat)
    store_user_service_areas.each do |store_user_service_area|
      if Order.unscoped.where({ store_user_id: store_user_service_area.store_user_id, booked_at: booked_at }).count==0
        return store_user_service_area.store_user_id
      end
    end
    false
  end

  def areas
    coordinates = self.service_area.areas.split(',')
    coordinates = (0..coordinates.length-1).step(2).map do |i|
      [coordinates[i].to_f, coordinates[i+1].to_f]
    end
    coordinates << coordinates[0]
    {
      type: 'polygon',
      coordinates: [coordinates]
    }
  end

  def as_indexed_json(options={})
    {
      store_id: self.store_user.store_id,
      store_user_id: self.store_user_id,
      product_id: self.service_area.product_id,
      areas: areas
    }
  end
end

StoreUserServiceArea.import force: true
