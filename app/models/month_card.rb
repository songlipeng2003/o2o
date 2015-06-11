class MonthCard < ActiveRecord::Base
  include AASM

  belongs_to :user
  belongs_to :car
  belongs_to :application
  has_many :orders

  validates :license_tag, presence: true
  validates :car, presence: true
  validates :started_at, presence: true
  validates :name, presence: true

  aasm column: :state do
    state :available, :initial => true
    state :expired

    event :expire do
      transitions from: :available, to: :expired
    end
  end

  def update_use_count
    self.use_count = Order.where(month_card_id: id).count
    self.update_attribute(:use_count, use_count)
  end

  def self.auto_expired
    self.where(state: 'available').where("expired_at<?", Time.now).find_each do |order|
      order.expire!
    end
  end
end
