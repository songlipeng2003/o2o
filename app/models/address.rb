class Address < ActiveRecord::Base
  validates :place, presence: true
  validates :address_type, presence: true, inclusion: { in: %w(home company other) }
  validates :lat, presence: true
  validates :lon, presence: true

  belongs_to :user

  default_value_for :address_type, 'other'
end
