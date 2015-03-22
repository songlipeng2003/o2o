class SystemProduct < ActiveRecord::Base
  belongs_to :category

  validates :name, presence: true
  validates :image, presence: true
  validates :description, presence: true

  mount_uploader :image, SystemProductImageUploader
end
