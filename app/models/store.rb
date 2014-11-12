class Store < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  validates :address, presence: true
  validates :phone, presence: true
  validates :description, presence: true
end
