class Finance < ActiveRecord::Base
  belongs_to :financeable, polymorphic: true
  has_many :trading_records

  def total_balance
    balance + freeze_balance
  end
end
