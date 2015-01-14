module V1
  class Users < Grape::API
    resource :users do
      desc "用户详情", hidden: true
      params do
        requires :id, type: Integer, desc: "ID"
      end
      route_param :id do
        get do
          User.find(params[:id])
        end
      end

      desc '更新用户信息', {
        headers: {
          "X-Access-Token" => {
            description: "Token",
            required: true
          },
        }
      }
      params do
        requires :avatar, type: String, desc: '头像'
        requires :nickname, type: String, desc: '昵称'
        requires :sex, type: String, desc: '性别'
      end
      put do
        authenticate!

      end

      desc "是否设置支付密码（仅能访问登录用户自己）", {
        headers: {
          "X-Access-Token" => {
            description: "Token",
            required: true
          },
        }
      }
      params do
        requires :id, type: Integer, desc: "ID"
      end
      route_param :id do
        get :is_set_pay_password do
          authenticate!
          error!("Forbidden", 403) unless current_user.id==params[:id]
          !current_user.encrypted_pay_password.blank?
        end
      end
    end
  end
end
