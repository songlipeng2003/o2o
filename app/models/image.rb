class Image < ActiveRecord::Base
  validates :file, presence: true
  belongs_to :item, polymorphic: true

  has_one_attached :image

  before_save :update_file_attributes

  after_create do
  end

  private
  def update_file_attributes
    if file.present? && file_changed?
      self.filesize = file.file.size
    end
  end
end
