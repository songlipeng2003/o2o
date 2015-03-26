class StoreUser < ActiveRecord::Base
  GENDERS = %w(男 女 )

  belongs_to :store

  has_many :login_histories, as: :user

  validates :phone, presence: true, phone: true, uniqueness: true
  validates :username, key: true, length: { minimum: 6 }, allow_blank: true

  before_save :ensure_authentication_token

  devise :database_authenticatable, :trackable, :validatable

  has_paper_trail

  def ensure_authentication_token
    self.authentication_token ||= generate_authentication_token
  end

  def email_required?
    false
  end

  def to_s
    phone
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
