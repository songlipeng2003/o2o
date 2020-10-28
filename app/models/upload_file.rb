class UploadFile < ActiveRecord::Base
  belongs_to :application

  validates :file, presence: true

  has_one_attached :file

  before_save :update_file_attributes

  private
  def update_file_attributes
    if file.present? && file_changed?
      self.filesize = file.file.size
    end
  end
end
