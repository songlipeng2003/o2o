class Order < ActiveRecord::Base
  include AASM

  belongs_to :user
  belongs_to :store
  belongs_to :car

  validates :user_id, presence: true
  validates :store_id, presence: true
  validates :car_id, presence: true
  validates :car_model_id, presence: true
  validates :car_color, presence: true
  validates :license_tag, presence: true
  validates :phone, presence: true
  validates :address_id, presence: true
  validates :place, presence: true
  validates :lat, presence: true
  validates :lon, presence: true
  validates :product_id, presence: true
  validates :booked_at, presence: true
  validates :note, length: { maximum: 255 }

  validates_associated :user
  validates_associated :store
  validates_associated :car
  # validates_associated :product

  before_create :cal_total_amount

  has_paper_trail

  aasm column: :state do
    state :unpayed, :initial => true
    state :payed
    state :finished
    state :closed

    event :pay do
      transitions :from => :unpayed, :to => :payed

      after do
        trading_record = TradingRecord.new
        trading_record.user_id = self.user_id
        trading_record.type = TradingRecord::TYPE_EXPENSE
        trading_record.object = self
        trading_record.amount = this.total_amount
        trading_record.save
      end
    end

    event :close do
      transitions :from => :unpayed, :to => :closed
    end

    event :finish do
      transitions :from => :payed, :to => :finished
    end
  end

  def cal_total_amount
    self.total_amount ||= 15;
  end
end
