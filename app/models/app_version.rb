class AppVersion < ActiveRecord::Base
  validate :file, presence: true
  validate :version, presence: true

  mount_uploader :file, AppVersionFileUploader
end
