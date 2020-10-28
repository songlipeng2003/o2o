class BannerGroup < ApplicationRecord
  validates :key, presence: true, uniqueness: true
  validates :name, presence: true, uniqueness: true
end
