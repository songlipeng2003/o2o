class Coupon < ActiveRecord::Base
  include AASM

  belongs_to :user
  belongs_to :system_coupon

  validates :user_id, presence: true
  validates :system_coupon_id, presence: true
  validates :amount, presence: true

  aasm column: :state do
    state :unused, :initial => true
    state :used
    state :expired
  end
end
