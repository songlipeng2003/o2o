class AdminUser < ActiveRecord::Base

  has_many :login_histories, as: :user

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable


  def update_tracked_fields!(request)
    self.login_histories.create({
      ip: request.remote_ip,
      device: request.remote_ip,
      device_model: request.env['HTTP_USER_AGENT'],
      device_type: 'web',
      application_id: 4
    })
    super(request)
  end
end
