class UploadFile < ActiveRecord::Base
  mount_uploader :file, FileUploader
end
