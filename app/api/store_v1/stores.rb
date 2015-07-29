module StoreV1
  class Stores < Grape::API
    resource :stores do
      desc "获取店铺用户", {
        headers: {
          "X-Access-Token" => {
            description: "Token",
            required: true
          },
        }
      }
      route_param :id do
        get :store_users do
          @store = Store.find(params[:id])
          present @store.store_users, with: StoreV1::Entities::StoreUserList
        end
      end
    end
  end
end
