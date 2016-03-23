class WashMachine < ActiveRecord::Base
  belongs_to :province, class_name: 'Area'
  belongs_to :city, class_name: 'Area'
  belongs_to :area

  validates :code, presence: true, uniqueness: true
  validates :lat, presence: true
  validates :lon, presence: true
  validates :address, presence: true
  validates :price, presence: true, :numericality => { greater_than: 0 }
  validates :province, presence: true
  validates :city, presence: true
  validates :area, presence: true

  validates_associated :province
  validates_associated :city
  validates_associated :area
end
