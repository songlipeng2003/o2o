class Finance < ActiveRecord::Base
  belongs_to :financeable, polymorphic: true
end
