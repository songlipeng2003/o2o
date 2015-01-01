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

      desc '更新用户信息'
      params do
        requires :avatar, type: String, desc: '头像'
        requires :nickname, type: String, desc: '昵称'
        requires :sex, type: String, desc: '性别'
      end
      put do

      end
    end
  end
end
