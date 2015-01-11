module V1
  class Addresses < Grape::API
    before do
      error!("401 Unauthorized", 401) unless authenticated
    end

    resource :addresses do
      desc "地址", {
        headers: {
          "X-Access-Token" => {
            description: "Token",
            required: true
          },
        }
      }
      get do
        present current_user.addresses.all
      end

      desc "地址详情", {
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
        get do
          present current_user.addresses.find(params[:id])
        end
      end

      desc "添加地址", {
        headers: {
          "X-Access-Token" => {
            description: "Token",
            required: true
          },
        }
      }
      params do
        requires :place, type: String, desc: "地址"
        optional :address_type, type: String, desc: "类型：home,company,other，可不填，默认other"
        requires :lat, type: String, desc: "纬度"
        requires :lon, type: String, desc: "经度"
      end
      post do
        present current_user.addresses.create(permitted_params)
      end

      desc "编辑地址", {
        headers: {
          "X-Access-Token" => {
            description: "Token",
            required: true
          },
        }
      }
      params do
        requires :id, type: Integer, desc: "ID"
        requires :place, type: String, desc: "地址"
        requires :lat, type: String, desc: "纬度"
        requires :lon, type: String, desc: "经度"
      end
      route_param :id do
        put do
          address = current_user.addresses.find(params[:id])
          present address.update(permitted_params)
        end
      end

      desc "删除地址", {
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
        delete do
          address = current_user.addresses.find(params[:id])
          present address.delete
        end
      end
    end
  end
end
