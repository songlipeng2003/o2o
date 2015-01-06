class Application < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  validates :token, presence: true, uniqueness: true

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
