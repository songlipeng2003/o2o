class TradingRecord < ActiveRecord::Base
  TYPE_RECHARGE = 1;
  TYPE_EXPENSE = 2;
  TYPE_PRESENT = 3;

  belongs_to :user
  belongs_to :object, polymorphic: true

  validates :user_id, presence: true
  validates :type, presence: true
  validates :amount, presence: true
  validates :object, presence: true
end
