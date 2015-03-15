class PaymentLog < ActiveRecord::Base
  include AASM

  belongs_to :item, polymorphic: true
  belongs_to :payment
  belongs_to :application

  validates :item, presence: true
  validates :payment, presence: true

  before_create do
    self.sn = gen_sn
  end

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
        item.pay(item.user)
        item.save
      end
    end

    event :close do
      transitions :from => :unpayed, :to => :closed

      after do
        self.closed_at = Time.now

        if self.payment.payment_type=='alipay' && self.out_trade_no
          Alipay::Service.close_trade(
            :trade_no     => self.out_trade_no,
            :out_order_no => self.sn
          )
        end
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

  def gen_sn
    sn = Time.now.strftime('%Y%m%d') + rand(100000...999999).to_s
    sn = gen_sn if Order.unscoped.where(sn: sn).first
    sn
  end
end
