class Area < ActiveRecord::Base
  include Tree

  # belongs_to :parent

  validates :name, presence: :true
end
