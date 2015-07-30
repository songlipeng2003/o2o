class Order < ActiveRecord::Base
  include AASM
  include Snable

  belongs_to :province, class_name: 'Area'
  belongs_to :city, class_name: 'Area'
  belongs_to :area, class_name: 'Area'

  belongs_to :product
  belongs_to :store_user
  belongs_to :user, counter_cache: true
  belongs_to :store, counter_cache: true
  belongs_to :car
  belongs_to :address
  belongs_to :car_model
  belongs_to :application
  belongs_to :coupon
  belongs_to :store_user, counter_cache: true
  belongs_to :month_card
  belongs_to :service_ticket

  has_one :evaluation

  has_many :payment_logs, as: :item
  has_one :payment_log, -> { order 'id DESC' }, as: :item

  validates :user_id, presence: true
  validates :store_id, presence: true
  validates :car_id, presence: true, on: :create
  validates :car_model_id, presence: true
  validates :car_color, presence: true
  validates :license_tag, presence: true
  validates :phone, presence: true
  validates :address_id, presence: true, on: :create
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
  validates_associated :store, on: :create
  validates_associated :car, on: :create
  # validates_associated :product

  before_create :cal_total_amount

  before_validation(on: :create) do
    self.car_model_id = self.car.car_model_id
    self.car_color = self.car.color
    self.license_tag = self.car.license_tag

    self.place = self.address.place
    self.lon = self.address.lon
    self.lat = self.address.lat

    self.store_id = self.store_user.store_id

    update_area_info
  end

  after_create do
    use_coupon

    month_card_auto_pay

    use_service_ticket
  end

  has_paper_trail

  acts_as_paranoid

  default_scope -> { order('id DESC') }

  aasm column: :state do
    state :unpayed, :initial => true
    state :payed
    state :confirmed
    state :finished
    state :closed

    event :pay, after: :log_state_change do
      transitions :from => :unpayed, :to => :payed

      after do
        if payment_log && payment_log.payment.code != 'month_card'
          if payment_log.payment.code != 'balance'
            trading_record = TradingRecord.new
            trading_record.user = self.user
            trading_record.trading_type = TradingRecord::TRADING_TYPE_RECHARGE
            trading_record.object = self
            trading_record.amount = self.total_amount
            trading_record.name = "充值#{trading_record.amount}"
            trading_record.save
          end

          trading_record = TradingRecord.new
          trading_record.user = self.user
          trading_record.trading_type = TradingRecord::TRADING_TYPE_EXPENSE
          trading_record.object = self
          trading_record.name = self.product.name
          trading_record.amount = -self.total_amount
          trading_record.save

          trading_record = TradingRecord.new
          trading_record.user = SystemUser.platform
          trading_record.trading_type = TradingRecord::TRADING_TYPE_IN
          trading_record.object = self
          trading_record.name = self.product.name
          trading_record.amount = self.total_amount
          trading_record.save

          params = {
            booked_at: self.booked_at.strftime('%F %T'),
            address: self.place,
            license_tag: self.license_tag,
            color: self.car_color,
            car_model: self.car_model_name,
            phone: self.phone,
            product: self.product.name,
            is_include_interior: self.is_include_interior ? '是' : '不',
            price: self.order_amount
          }
          SMSWorker.perform_async(self.store_user.phone, 910055, params)
        end
      end
    end

    event :close, after: :log_state_change do
      before do
        if self.payed?
          if Time.now.beginning_of_day != self.booked_at.beginning_of_day
            self.payment_log.refund!
          end
        end
      end

      transitions :from => [:unpayed, :payed], :to => :closed

      after do
        if self.payment_log && self.payment_log.unpayed?
          self.payment_log.close!
        end
      end
    end

    event :admin_close, after: :log_state_change do
      transitions :from => [:payed], :to => :closed

      after do
        if self.payment_log && self.payment_log.payed?
          self.payment_log.refund!
        end
      end
    end

    event :finish, after: :log_state_change do
      transitions from: [:payed, :confirmed], to: :finished
    end

    event :system_close, after: :log_state_change do
      transitions from: [:unpayed], to: :closed

      after do
        if self.payment_log && self.payment_log.unpayed?
          self.payment_log.close!
        end
      end
    end

    event :confirm, after: :log_state_change do
      transitions from: :payed, to: :confirmed
    end
  end

  def cal_total_amount
    # 洗车分车型计算价格
    if [1, 2].include? self.product_id
      unless self.car_model.auto_type=='SUV'
        self.product_id = 1
      else
        self.product_id = 2
      end
    end

    # 获取商品价格
    self.original_price = self.product.market_price
    price = self.product.price

    if [1, 2].include?(self.product_id)
      # 洗车是否包含内饰价格变动
      if is_include_interior
        if product_id==1
          price += 7
        else
          price += 10
        end
      end
    end

    self.order_amount = price

    # 代金券处理
    if self.coupon
      price = self.original_price - self.coupon.amount
    end

    # 第一单优惠处理
    if [1, 2].include?(self.product_id)
      if user.orders.with_deleted.count == 0 || user.orders.with_deleted.count == user.orders.with_deleted.where(state: 'closed').count
        if license_tag
          if license_tag && Order.where(license_tag: license_tag, state: ['payed', 'finished']).count==0
            price = 1
            self.order_amount = 1
          end
        else
          price = 1
          self.order_amount = 1
        end
      end
    end

    # 消费卡处理
    month_card = user.month_cards.where(license_tag: license_tag).order('id DESC').first
    if month_card && booked_at && month_card.available? && booked_at<month_card.expired_at
      price = 0
      self.month_card_id = month_card.id
    end

    # 消费券处理
    service_ticket && [1, 2].include?(self.product_id) && price = 0

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
    self.where(state: 'unpayed').where("created_at<?", 30.minutes.ago).find_each do |order|
      order.system_close! nil, remark: '超时未付款，系统自动关闭'
    end
  end

  def log_state_change(user, params={})
    order_log = OrderLog.new
    order_log.order = self
    order_log.user = user
    order_log.state = aasm.from_state
    order_log.changed_state = aasm.to_state
    order_log.remark = params[:remark]
    order_log.save
  end

  def store_user_id=(store_user_id)
    super(store_user_id)

    self.store_id = store_user.store_id
  end

  def change_store_user!(store_user_id)
    self.store_user_id = store_user_id
    self.save

    params = {
      booked_at: self.booked_at.strftime('%F %T'),
      address: self.place,
      license_tag: self.license_tag,
      color: self.car_color,
      car_model: self.car_model_name,
      phone: self.phone,
      product: self.product.name,
      is_include_interior: self.is_include_interior ? '是' : '不'
    }
    store_user = StoreUser.find(store_user_id)
    SMSWorker.perform_async(store_user.phone, 671257, params)
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
    coupon.use! if coupon
  end

  def month_card_auto_pay
    if [1, 2].include?(product_id)
      month_card = user.month_cards.where(license_tag: license_tag).order('id DESC').first

      if month_card && month_card.available? && booked_at<month_card.expired_at
        pay! user

        month_card.update_use_count

        self.service_ticket_id = nil
      end
    end
  end

  def use_service_ticket
    if service_ticket && [1, 2].include?(product_id)
      service_ticket.order_amount = order_amount
      service_ticket.user_id = user_id
      service_ticket.use!

      pay! user
    end
  end
end
