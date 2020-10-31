class Category < ActiveRecord::Base
  include Tree

  validates :name, presence: true, uniqueness: true

  has_one_attached :image
end
