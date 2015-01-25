class Community < ActiveRecord::Base

  belongs_to :area

  validates :area_id, presence: true
  validates :name, presence: true
  validates :address, presence: true
  validates :lon, presence: true, numericality: true
  validates :lat, presence: true, numericality: true

  validates_associated :area

  include ElasticsearchSearchable

  def location
    { lat: lat, lon: lon}
  end

  # elasticsearch settings
  settings index: { number_of_shards: 1 } do
    mappings dynamic: 'strict' do
      indexes :name
      indexes :address
      indexes :location, type: 'geo_point'
    end
  end

  def as_indexed_json(options={})
    self.as_json(only: [:name, :address, :location])
  end
end

Community.import
