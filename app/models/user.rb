class User < ActiveRecord::Base

  validates :phone, presence: true, uniqueness: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def self.random_email
    name = (0..10).map { ('a'..'z').to_a[rand(8)] }.join

    name + '@24didi.com'
  end
end
