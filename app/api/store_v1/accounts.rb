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
      end
      post 'login' do
        # username = params[:username]

        # store_user.update_tracked_fields!(warden.request)

        # store_user.login_histories.create({
        #   ip: env['REMOTE_ADDR'],
        #   device: params[:device],
        #   device_model: params[:device_model],
        #   device_type: params[:device_type]
        # })

        # present :code, 0
        # present :msg, '登录成功'
        # present :data, store_user, with: V1::Entities::StoreUser
      end
    end
  end
end
