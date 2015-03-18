class SystemUser < ActiveRecord::Base
  include Financeable

  validates :code, presence: true, uniqueness: true
  validates :name, presence: true, uniqueness: true
end
