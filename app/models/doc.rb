class Doc < ActiveRecord::Base
  validates :title, presence: true, uniqueness: true
  validates :key, presence: true, uniqueness: true, key: true
  validates :content, presence: true
end
