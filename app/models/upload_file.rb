class UploadFile < ActiveRecord::Base
  belongs_to :application

  validates :file, presence: true

  mount_uploader :file, FileUploader

  before_save :update_file_attributes

  private
  def update_file_attributes
    if file.present? && file_changed?
      self.filesize = file.file.size
    end
  end
end
