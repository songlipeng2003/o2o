class SystemUser < ActiveRecord::Base
  include Financeable

  validates :code, presence: true, uniqueness: true
  validates :name, presence: true, uniqueness: true

  def self.platform
    return self.where(code: :platform).first
  end

  def self.company
    return self.where(code: :company).first
  end
end
