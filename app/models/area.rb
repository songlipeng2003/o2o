class Area < ActiveRecord::Base
  belongs_to :parent

  has_ancestry
end
