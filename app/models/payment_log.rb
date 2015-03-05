class PaymentLog < ActiveRecord::Base
  include AASM

  belongs_to :item, polymorphic: true
  belongs_to :payment

  validates :item, presence: true
  validates :payment, presence: true

  aasm column: :state do
    state :unpayed, :initial => true
    state :payed
    state :closed
  end
end
