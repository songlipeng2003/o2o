class WashMachineSet < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  validates :image, presence: true
  validates :price, presence: true, :numericality => { greater_than: 0 }

  mount_uploader :image, ProductImageUploader
end
