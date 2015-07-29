module StoreV1
  class Accounts < Grape::API
    resource :accounts do
      desc "登陆"
      params do
        requires :username, type: String, desc: "用户名"
        requires :password, type: String, desc: "密码"
        optional :device, type: String, desc: "设备唯一编号"
        optional :device_model, type: String, desc: "设备型号，例如：小米Note"
        optional :device_type, type: String, desc: "设备类型，android或者ios"
        optional :jpush, type: String, desc: "极光推送ID"
      end
      post 'login' do
        store_user = StoreUser.where("username=:username OR phone=:username", username: params[:username]).first();
        unless store_user
          return {
            code: 1,
            msg: '账号或密码错误'
          }
        end
        if store_user.valid_password?(params[:password])
          store_user.update_tracked_fields!(warden.request)

          store_user.login_histories.create!({
            ip: env['X-Forwarded-For'],
            device: params[:device],
            device_model: params[:device_model],
            device_type: params[:device_type]
          })

          unless params[:device].blank?
            device = store_user.devices.where(code: params[:device]).first_or_create! do |device|
              device.device_type = params[:device_type]
            end
            device.jpush = params[:jpush]
            device.save!
          end

          present :code, 0
          present :msg, '登录成功'
          present :data, store_user, with: StoreV1::Entities::StoreUser
        else
          {
            code: 1,
            msg: '账号或密码错误'
          }
        end
      end
    end
  end
end
