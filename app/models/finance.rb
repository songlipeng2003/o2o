class Finance < ActiveRecord::Base
  belongs_to :financeable, polymorphic: true
  has_many :trading_records
end
