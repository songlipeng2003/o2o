class WashMachine < ActiveRecord::Base
  validates :code, presence: true, uniqueness: true
  validates :lat, presence: true
  validates :lon, presence: true
  validates :address, presence: true
  validates :price, presence: true, :numericality => { greater_than: 0 }
end
