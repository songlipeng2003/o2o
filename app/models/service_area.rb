class ServiceArea < ActiveRecord::Base
  belongs_to :product

  validates :name, presence: true
  validates :areas, presence: true
end
