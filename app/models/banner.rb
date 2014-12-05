class Banner < ActiveRecord::Base
  validates :image, presence: true
  validates :link, presence: true

  mount_uploader :image, BannerImageUploader
end
