class ServiceTicketBatch < ActiveRecord::Base
  belongs_to :big_customer
  has_many :service_tickets

  validates :big_customer, presence: true
  validates :number, presence: true, :numericality => { :only_integer => true, greater_than_or_equal_to: 0 }

  after_save do
    gen_service_tickets
  end

  def gen_service_tickets
    number.times.each do
      service_ticket = self.service_tickets.new
      service_ticket.big_customer_id = self.big_customer_id
      service_ticket.save
    end
  end
end
