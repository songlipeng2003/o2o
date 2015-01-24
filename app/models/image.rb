class Image < ActiveRecord::Base
  validates :file, presence: true
  validates :filesize, presence: true
  belongs_to :object, polymorphic: true
end
