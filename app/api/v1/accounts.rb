module V1
  class Accounts < Grape::API
    resource :accounts do
      desc "注册"
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
            user
          else
            {
              message: user.errors
            }
          end
        else
          {
            message: '验证码失败'
          }
        end
      end

      desc "登陆"
      params do
        requires :phone, type: String, desc: "手机号"
        requires :code, type: String, desc: "验证码"
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
        user = User.where('phone=?', phone)
        unless user
          password = User.random_password
          user = User.new({
            email: User.random_email,
            phone: phone,
            password: password,
            password_confirmation: password
          })
        end

        {
          code: 0,
          msg: '登录成功',
          data: user
        }
      end
    end
  end
end
