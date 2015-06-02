require 'securerandom'
require 'digest'

class ServiceTicket < ActiveRecord::Base
  include AASM

  belongs_to :big_customer
  belongs_to :user
  belongs_to :service_ticket_batch
  has_one :order

  validates :code, presence: true

  before_validation :gen_code

  aasm column: :state do
    state :available, :initial => true
    state :used

    event :use do
      transitions :from => :available, :to => :used

      after do
        service_ticket_batch.update_attribute :used_count, service_ticket_batch.service_tickets.used.count

        trading_record = TradingRecord.new
        trading_record.user = big_customer
        trading_record.trading_type = TradingRecord::TRADING_TYPE_EXPENSE
        trading_record.object = order
        trading_record.name = order.product.name
        trading_record.amount = -order.total_amount
        trading_record.save
      end
    end
  end

  private
  def gen_code
    code = Digest::MD5.hexdigest(SecureRandom.hex(16))[0...8].upcase
    code = gen_code if ServiceTicket.where(code: code).first
    self.code = code
  end
end
