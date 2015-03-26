class AppVersion < ActiveRecord::Base
  validates :file, presence: true
  validates :version, presence: true

  mount_uploader :file, AppVersionFileUploader
end
