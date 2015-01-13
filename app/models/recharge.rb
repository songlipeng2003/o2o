class Recharge < ActiveRecord::Base
  include AASM

  validates :user_id, presence: true
  validates :amount, presence: true
  validates_associated :recharge_policy

  belongs_to :user
  belongs_to :recharge_policy

  before_validation :ensure_amount

  def ensure_amount
    self.amount ||= recharge_policy.amount
  end

  aasm column: :state do
    state :unpayed, :initial => true
    state :payed
    state :failed

    event :pay do
      transitions :from => :unpayed, :to => :payed
    end

    event :fail do
      transitions :from => :unpayed, :to => :failed
    end
  end
end
