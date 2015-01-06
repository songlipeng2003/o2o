module V1
  class Addresses < Grape::API
    before do
      error!("401 Unauthorized", 401) unless authenticated
    end

    resource :addresses do
      desc "地址"
      get do
        present current_user.addresses.all
      end

      desc "地址详情"
      params do
        requires :id, type: Integer, desc: "ID"
      end
      route_param :id do
        get do
          present current_user.addresses.find(params[:id])
        end
      end

      desc "添加地址"
      params do
        requires :address, type: String, desc: "地址"
        optional :type, type: String, desc: "类型：home,company,other，可不填，默认other"
        requires :lat, type: Float, desc: "纬度"
        requires :lon, type: Float, desc: "经度"
      end
      post do
        present current_user.addresses.create(params)
      end

      desc "编辑地址"
      params do
        requires :id, type: Integer, desc: "ID"
        requires :address, type: String, desc: "地址"
        requires :lat, type: Float, desc: "纬度"
        requires :lon, type: Float, desc: "经度"
      end
      route_param :id do
        put do
          address = current_user.addresses.find(params[:id])
          present address.update(params)
        end
      end

      desc "删除地址"
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
