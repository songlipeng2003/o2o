class Order < ActiveRecord::Base
  include AASM

  belongs_to :province, class_name: 'Area'
  belongs_to :city, class_name: 'Area'
  belongs_to :area, class_name: 'Area'

  belongs_to :product
  belongs_to :user
  belongs_to :store
  belongs_to :car
  belongs_to :address
  belongs_to :car_model
  belongs_to :application
  belongs_to :coupon

  has_one :evaluation

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
  validates :province, presence: true
  validates :city, presence: true
  validates :area, presence: true

  validate :check_coupon

  validates_associated :province
  validates_associated :city
  validates_associated :area
  validates_associated :user
  validates_associated :store
  validates_associated :car
  # validates_associated :product

  before_create do
    cal_total_amount
  end

  before_validation(on: :create) do
    self.car_model_id = self.car.car_model_id
    self.car_color = self.car.color
    self.license_tag = self.car.license_tag

    self.place = self.address.place
    self.lon = self.address.lon
    self.lat = self.address.lat

    update_area_info
  end

  after_create do
    if self.coupon
      use_coupon
    end
  end

  has_paper_trail

  default_scope -> { order('id DESC') }

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
        trading_record.trading_type = TradingRecord::TRADING_TYPE_EXPENSE
        trading_record.object = self
        trading_record.amount = -self.total_amount
        trading_record.save

        params = {
          booked_at: self.booked_at,
          address: self.place,
          license_tag: self.license_tag,
          color: self.car_color,
          car_model: self.car_model_name,
          phone: self.phone
        }
        SMSWorker.perform_async(self.store.phone, 671257, params)
      end
    end

    event :close do
      before do
        if self.payed?
          if Time.now.beginning_of_day != self.booked_at.beginning_of_day
            trading_record = TradingRecord.new
            trading_record.user_id = self.user_id
            trading_record.trading_type = TradingRecord::TRADING_TYPE_RETURN
            trading_record.object = self
            trading_record.amount = self.total_amount
            trading_record.save
          end
        end
      end

      transitions :from => [:unpayed, :payed], :to => :closed
    end

    event :admin_close do
      transitions :from => [:payed], :to => :closed
    end

    event :finish do
      transitions :from => :payed, :to => :finished
    end
  end

  def cal_total_amount
    if [1, 2].include? self.product_id
      unless self.car_model.auto_type=='SUV'
        self.product_id = 1
      else
        self.product_id = 2
      end
    end

    self.original_price = self.product.price
    price = self.original_price

    if self.coupon
      price = self.original_price - self.coupon.amount
    end

    self.total_amount ||= price;
  end

  def car_model_name
    car_model.name
  end

  def product_type_text
    product.name
  end

  def check_coupon
    return !self.coupon.blank? && self.coupon.unused? && self.coupon.user_id==self.user_id
  end

  def self.auto_close_expired_order
    self.where(state: 'unpayed').where("created_at<?", 1.hour.ago).find_each do |order|
      order.close
    end
  end

  private
  def update_area_info
    if store
      self.area = self.store.area
      self.city_id = self.area.parent.id
      self.province_id = self.area.parent.parent.id
    end
  end

  def use_coupon
    self.coupon.use
    self.coupon.save
  end
end
