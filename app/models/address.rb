class Address < ActiveRecord::Base
  validates :address, presence: true
  validates :type, presence: true, inclusion: { in: %w(home company other) }
  validates :lat, presence: true
  validates :lon, presence: true

  belongs_to :user

  default_value_for :type, 'other'
end
