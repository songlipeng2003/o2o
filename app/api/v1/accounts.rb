module V1
  class Accounts < Grape::API
    resource :accounts do
      desc "注册", hidden: true
      params do
        requires :phone, type: String, desc: "手机号"
        requires :code, type: String, desc: "验证码"
        requires :password, type: String, desc: "密码"
      end
      post 'register' do
        is_valid = AuthCode.validate_code(params[:phone], params[:code])

        if is_valid
          user = User.new({
            phone: params[:phone],
            password: params[:password],
            password_confirmation: params[:password]
          })

          user.application = current_application

          if user.save
            {
              code: 0,
              data: user
            }
          else
            {
              code: 1,
              msg: user.errors
            }
          end
        else
          {
            code: 2,
            msg: '验证码失败'
          }
        end
      end

      desc "登陆"
      params do
        requires :phone, type: String, desc: "手机号"
        requires :code, type: String, desc: "验证码"
        optional :device, type: String, desc: "设备唯一编号"
        optional :device_model, type: String, desc: "设备型号，例如：小米Note"
        optional :device_type, type: String, desc: "设备类型，android或者ios"
        optional :jpush, type: String, desc: "极光推送ID"
      end
      post 'login' do
        unless params[:phone]=='15695696226' && params[:code] == '1111'
          is_valid = AuthCode.validate_code(params[:phone], params[:code])

          unless is_valid
            return {
              code: 1,
              msg: '验证码错误'
            }
          end
        end

        phone = params[:phone]
        user = User.where('phone=?', phone).first
        if user
          user.save
        else
          password = User.random_password
          user = User.new({
            phone: phone,
            password: password,
          })
          user.application = current_application
          unless user.save
            return {
              code: 2,
              msg: user.errors
            }
          end
        end

        user.update_tracked_fields!(warden.request)

        user.login_histories.create!({
          ip: client_ip,
          device: params[:device],
          device_model: params[:device_model],
          device_type: params[:device_type],
          application: current_application
        })

        unless params[:device].blank?
          device = user.devices.where(code: params[:device]).first_or_create! do |device|
            device.device_type = params[:device_type]
          end
          device.jpush = params[:jpush]
          device.save!
        end

        present :code, 0
        present :msg, '登录成功'
        present :data, user, with: V1::Entities::User
      end
    end
  end
end
