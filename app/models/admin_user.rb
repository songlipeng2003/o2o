class AdminUser < ActiveRecord::Base

  has_many :login_histories, as: :user

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable


  def update_tracked_fields!(request)
    self.login_histories.create({
      ip: request.env['REMOTE_ADDR'],
      device: request.env['REMOTE_ADDR'],
      device_model: request.env['HTTP_USER_AGENT'],
      device_type: 'web'
    })
    super(request)
  end
end
