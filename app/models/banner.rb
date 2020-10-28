class Banner < ActiveRecord::Base
  validates :image, presence: true
  validates :link, presence: true

  has_one_attached :image
  belongs_to :banner_group
end
