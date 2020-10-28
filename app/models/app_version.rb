class AppVersion < ActiveRecord::Base
  validates :file, presence: true
  validates :version, presence: true

  has_one_attached :file
end
