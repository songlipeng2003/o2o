class ServiceTicket < ActiveRecord::Base
  include AASM

  belongs_to :big_customer
  belongs_to :user
  belongs_to :service_ticket_batch

  validates :code, presence: true

  before_validation :gen_code

  aasm column: :state do
    state :available, :initial => true
    state :used
  end

  def gen_code
    code = Time.now.strftime('%Y%m%d') + rand(100000...999999).to_s
    code = gen_code if ServiceTicket.where(code: code).first
    self.code = code
  end
end
