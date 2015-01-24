class Product < ActiveRecord::Base
  validates :name, presence: true
  validates :price, presence: true, :numericality => { greater_than_or_equal_to: 0 }
  validates :description, presence: true
end
