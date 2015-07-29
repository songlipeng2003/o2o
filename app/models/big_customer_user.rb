class BigCustomerUser < ActiveRecord::Base
  include Tokenable

  belongs_to :big_customer

  has_many :login_histories, as: :user

  validates :phone, presence: true, phone: true, uniqueness: true
  validates :username, length: { minimum: 6 }, uniqueness: true, allow_blank: true

  devise :database_authenticatable, :trackable, :validatable

  has_paper_trail

  def email_required?
    false
  end
end
