class TradingRecord < ActiveRecord::Base
  TYPE_RECHARGE = 1;
  TYPE_EXPENSE = 2;

  belongs_to :user

  validates :user_id, presence: true
  validates :type, presence: true
  validates :amount, presence: true
  validates :object, presence: true
end
