class Application < ActiveRecord::Base
  APP_TYPE_IOS = 'ios'
  APP_TYPE_ANDROID = 'android'

  APPT_TYPES = %w{ ios android wap web }

  validates :name, presence: true, uniqueness: true
  validates :token, presence: true, uniqueness: true
  validates :umeng_app_key, presence: true, uniqueness: true
  validates :app_master_secret, presence: true, uniqueness: true
  validates :app_type, presence: true

  has_many :app_payments, dependent: :destroy
  has_many :payments, through: :app_payments

  accepts_nested_attributes_for :app_payments, reject_if: :all_blank, allow_destroy: true

  default_value_for :token  do
    self.generate_token
  end

  def self.generate_token
    loop do
      token = (0..10).map { ('a'..'z').to_a[rand(26)] }.join
      break token unless Application.where(token: token).first
    end
  end
end
