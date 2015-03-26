class User < ActiveRecord::Base
  include Financeable

  has_many :cars
  has_many :orders
  has_many :addresses
  has_many :recharges
  has_many :trading_records
  has_many :images
  has_many :login_histories, as: :user
  has_many :coupons

  validates :phone, presence: true, uniqueness: true

  before_save :ensure_authentication_token

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_paper_trail

  mount_uploader :avatar, AvatarUploader

  def ensure_authentication_token
    self.authentication_token ||= generate_authentication_token
  end

  def pay_password=(pay_password)
    self.encrypted_pay_password = password_digest(pay_password)
  end

  def display_name
    phone
  end

  def validate_pay_password(pay_password)
    return false if encrypted_pay_password.blank?
    bcrypt   = ::BCrypt::Password.new(encrypted_pay_password)
    if self.class.pepper.present?
      pay_password = "#{pay_password}#{self.class.pepper}"
    end
    pay_password = ::BCrypt::Engine.hash_secret(pay_password, bcrypt.salt)
    Devise.secure_compare(pay_password, encrypted_pay_password)
  end

  def email_required?
    false
  end

  def is_set_pay_password
    !self.encrypted_pay_password.blank?
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end

  def self.random_password
    (0..10).map { ('a'..'z').to_a[rand(8)] }.join
  end

  private

  def generate_authentication_token
    loop do
      token = Devise.friendly_token
      break token unless User.where(authentication_token: token).first
    end
  end
end
