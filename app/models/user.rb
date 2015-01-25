class User < ActiveRecord::Base

  has_many :cars
  has_many :orders
  has_many :addresses
  has_many :recharges
  has_many :trading_records
  has_many :images
  has_many :login_histories

  validates :phone, presence: true, uniqueness: true

  before_save :ensure_authentication_token

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_paper_trail

  def ensure_authentication_token
    self.authentication_token ||= generate_authentication_token
  end

  def pay_password=(pay_password)
    self.encrypted_pay_password = password_digest(pay_password)
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end

  def self.random_email
    name = (0..10).map { ('a'..'z').to_a[rand(8)] }.join

    name + '@24didi.com'
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
