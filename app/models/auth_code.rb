class AuthCode < ActiveRecord::Base
  validates :phone, presence: true
  validates :code, presence: true
  validates :expired_at, presence: true

  def self.generate(phone)
    code = self.gen_code

    auth_code = AuthCode.new
    auth_code.phone = phone
    auth_code.code = code
    auth_code.expired_at = Time.now + 30.minutes

    auth_code.save

    code
  end

  def self.validate_code(phone, code)
    auth_code = self.where("phone=? AND code=?", phone, code).first

    return !auth_code.blank? && auth_code.expired_at > Time.now
  end

  private
  def self.gen_code
    (0..5).map { (1..9).to_a[rand(8)] }.join
  end
end
