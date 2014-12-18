class Community < ActiveRecord::Base

  belongs_to :area

  validates :area_id, presence: true
  validates :name, presence: true
  validates :address, presence: true
  validates :lon, presence: true
  validates :lat, presence: true

  validates_associated :area
end
