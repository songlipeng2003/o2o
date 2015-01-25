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
            email: User.random_email,
            phone: params[:phone],
            password: params[:password],
            password_confirmation: params[:password]
          })

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
        optional :devise, type: String, desc: "设备编号"
        optional :devise_type, type: String, desc: "设备类型，android或者ios"
      end
      post 'login' do
        is_valid = AuthCode.validate_code(params[:phone], params[:code])

        unless is_valid
          return {
            code: 1,
            msg: '验证码错误'
          }
        end

        phone = params[:phone]
        user = User.where('phone=?', phone).first
        unless user
          password = User.random_password
          user = User.new({
            email: User.random_email,
            phone: phone,
            password: password
          })
          unless user.save
            return {
              code: 2,
              msg: user.errors
            }
          end
        end

        user.login_histories.create({
          ip: env['REMOTE_ADDR'],
          devise: params[:devise],
          devise_type: params[:deivse_type]
        })

        {
          code: 0,
          msg: '登录成功',
          data: user
        }
      end
    end
  end
end
