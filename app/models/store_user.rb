class StoreUser < ActiveRecord::Base
  include Tokenable

  GENDERS = %w(男 女 )

  belongs_to :store

  has_many :login_histories, as: :user

  validates :phone, presence: true, phone: true, uniqueness: true
  validates :username, length: { minimum: 6 }, allow_blank: true

  devise :database_authenticatable, :trackable, :validatable

  has_paper_trail

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
end
