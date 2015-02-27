class ProductType < ActiveRecord::Base
  validates :name, presence: true
end
