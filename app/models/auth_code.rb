class AuthCode < ActiveRecord::Base
  validates :phone, presence: true
  validates :code, presence: true
  validates :expired_at, presence: true

  def is_can_resend
    created_at <  (Time.now - 1.minutes)
  end

  def is_expired
    expired_at < (Time.now - 10.minutes)
  end

  def self.generate(phone)
    self.clear_expired_codes

    auth_code = self.where("phone=?", phone).first

    if auth_code
      code = auth_code.is_expired ? self.gen_code : auth_code.code
    else
      code = self.gen_code

      auth_code = AuthCode.new
      auth_code.phone = phone
    end

    auth_code.code = code
    auth_code.expired_at = Time.now + 10.minutes

    auth_code.save

    code
  end

  def self.validate_code(phone, code)
    self.clear_expired_codes

    auth_code = self.where("phone=? AND code=?", phone, code).first

    if !auth_code.blank? && auth_code.expired_at > Time.now
      auth_code.delete
      true
    else
      false
    end
  end

  private
  def self.gen_code
    (0..3).map { (1..9).to_a[rand(8)] }.join
  end

  def self.clear_expired_codes
    self.delete_all(["expired_at<?", 10.minutes.ago])
  end
end
