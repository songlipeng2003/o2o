class PaymentLog < ActiveRecord::Base
  include AASM

  belongs_to :item, polymorphic: true
  belongs_to :payment
  belongs_to :application

  validates :item, presence: true
  validates :payment, presence: true

  aasm column: :state do
    state :unpayed, :initial => true
    state :payed
    state :closed
    state :refunded

    event :pay do
      transitions :from => :unpayed, :to => :payed

      after do
        self.payed_at = Time.now

        item = self.item
        item.pay
        item.save
      end
    end

    event :close do
      transitions :from => :unpayed, :to => :closed

      after do
        self.closed_at = Time.now
      end
    end

    event :refund do
      transitions :from => :unpayed, :to => :refunded
    end
  end

  after_create :close_order_other_payments

  private

  def close_order_other_payments
    self.item.payment_logs.where(state: :unpayed).where.not(id: self.id).each do |payment_log|
      payment_log.close
      payment_log.save
    end
  end
end
