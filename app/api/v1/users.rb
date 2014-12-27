module V1
  class Users < Grape::API
    resource :users do
      desc "用户详情"
      params do
        requires :id, type: Integer, desc: "ID"
      end
      route_param :id do
        get do
          User.find(params[:id])
        end
      end
    end
  end
end
