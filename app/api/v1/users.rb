module V1
  class Users
    resource :users do
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
    end
  end
end
