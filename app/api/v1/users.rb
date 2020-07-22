module V1
  class Users < Grape::API
    resource :users do
      desc "用户详情"
      params do
        requires :id, type: Integer, desc: "用户编号"
      end
      route_param :id do
        get do
          present User.find(params[:id]), with: V1::Entities::User
        end
      end

      desc '更新用户信息'
      params do
        optional 'X-Access-Token', type: String, desc: 'Token', documentation: { in: :header }
        optional :avatar, type: String, desc: '头像'
        requires :nickname, type: String, desc: '昵称'
        requires :gender, type: String, desc: '性别, 男, 女'
      end
      put do
        authenticate!

        if !params[:avatar].blank?
          current_user.avatar = File.open(Rails.root.join('public', 'uploads', 'tmp') + params[:avatar])
        end
        current_user.nickname = params[:nickname]
        current_user.gender = params[:gender]

        current_user.save

        present current_user, with: V1::Entities::User
      end

      desc "是否设置支付密码（仅能访问登录用户自己）"
      params do
        optional 'X-Access-Token', type: String, desc: 'Token', documentation: { in: :header }
        requires :id, type: Integer, desc: "用户编号"
      end
      route_param :id do
        get :is_set_pay_password do
          authenticate!
          error!("403 Forbidden", 403) unless current_user.id==params[:id]
          {
            result: !current_user.encrypted_pay_password.blank?
          }
        end
      end

      desc "设置支付密码（仅能访问登录用户自己,设置密码接口仅在未设置支付密码时，设置一次）"
      params do
        optional 'X-Access-Token', type: String, desc: 'Token', documentation: { in: :header }
        requires :id, type: Integer, desc: "ID"
        requires :pay_password, type: String, desc: "支付密码,至少六位"
      end
      route_param :id do
        put :set_pay_password do
          authenticate!
          error!("403 Forbidden", 403) unless current_user.id==params[:id]
          error!("422 Unprocesable entity", 422) unless current_user.encrypted_pay_password.blank?
          current_user.pay_password = params[:pay_password]
          current_user.save
          present current_user, with: V1::Entities::User
        end
      end

      desc "获取个人信息,APP我的界面所需要的相关信息"
      params do
        optional 'X-Access-Token', type: String, desc: 'Token', documentation: { in: :header }
        requires :id, type: Integer, desc: "用户编号"
        requires :last_time, type: Integer, desc: "时间戳"
      end
      route_param :id do
        get :info do
          authenticate!
          error!("403 Forbidden", 403) unless current_user.id==params[:id]
          {
            balance: current_user.finance.balance,
            unreaded_msg_count: Announcement.count_of(params[:last_time])
          }
        end
      end

      desc "用户店铺列表", {
        headers: {
          "X-Access-Token" => {
            description: "Token",
            required: true
          },
        }
      }
      params do
        requires :id, type: Integer, desc: "用户编号"
      end
      route_param :id do
        get :stores do
          authenticate!
          error!("403 Forbidden", 403) unless current_user.id==params[:id]
          present current_user.stores
        end
      end

    end
  end
end
