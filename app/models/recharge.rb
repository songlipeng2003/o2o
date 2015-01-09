class Recharge < ActiveRecord::Base
  include AASM

  validate :user_id, presence: true
  validate :amount, presence: true

  belongs_to :user

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
