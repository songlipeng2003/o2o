class StoreUser < ActiveRecord::Base
  include Tokenable

  GENDERS = %w(男 女 )

  ROLE_MEMBER = 1

  ROLE_LEADER = 2

  ROLES = {
    ROLE_MEMBER => '成员',
    ROLE_LEADER => '组长'
  }

  belongs_to :store

  has_many :login_histories, as: :user
<<<<<<< HEAD
  has_many :store_user_service_areas, dependent: :destroy
  has_many :service_areas, through: :store_user_service_areas
=======
  has_many :orders
  has_many :devices, as: :deviceable
  has_many :evaluations
>>>>>>> v1

  validates :nickname, presence: true
  validates :phone, presence: true, phone: true, uniqueness: true
  validates :username, length: { minimum: 6 }, uniqueness: true, allow_blank: true

  devise :database_authenticatable, :trackable, :validatable

  has_paper_trail

  mount_uploader :avatar, StoreUserAvatarUploader

  def email_required?
    false
  end

  def to_s
    nickname
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end

  def role_name
    ROLES[role]
  end
end
