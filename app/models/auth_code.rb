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

  private
  def self.gen_code
    (0..5).map { (1..9).to_a[rand(8)] }.join
  end
end
