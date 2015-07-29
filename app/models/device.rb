class Device < ActiveRecord::Base
  belongs_to :deviceable, polymorphic: true

  validates :code, presence: true

  after_save :auto_change_device

  def auto_change_device
    device = Device.where(code: code).where.not(id: id).first
    if device
      device.delete
    end
  end
end
