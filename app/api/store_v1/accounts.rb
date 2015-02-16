module StoreV1
  class Accounts < Grape::API
    resource :accounts do
      desc "登陆"
      params do
        requires :username, type: String, desc: "用户名"
        requires :password, type: String, desc: "密码"
        # optional :device, type: String, desc: "设备唯一编号"
        # optional :device_model, type: String, desc: "设备型号，例如：小米Note"
        # optional :device_type, type: String, desc: "设备类型，android或者ios"
      end
      post 'login' do
        store_user = StoreUser.where(username: params[:username]).first();
        if store_user.valid_password?(params[:password])
          present :code, 0
          present :msg, '登录成功'
          present :data, store_user
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
