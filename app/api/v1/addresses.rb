module V1
  class Addresses < Grape::API
    before do
      error!("401 Unauthorized", 401) unless authenticated
    end

    resource :addresses do
      desc "地址", headers: {
          "X-Access-Token" => {
            description: "Token",
            required: true
          },
        },
        http_codes: [
         [200, '成功', V1::Entities::Address]
        ]
      get do
        present current_user.addresses.order('name DESC, id DESC').all, with: V1::Entities::Address
      end

      desc "地址详情",
        headers: {
          "X-Access-Token" => {
            description: "Token",
            required: true
          },
        },
        http_codes: [
          [200, 'Ok', V1::Entities::Address]
        ]
      params do
        requires :id, type: Integer, desc: "编号"
      end
      route_param :id do
        get do
          present current_user.addresses.find(params[:id]), with: V1::Entities::Address
        end
      end

      desc "添加地址",
        headers: {
          "X-Access-Token" => {
            description: "Token",
            required: true
          },
        },
        http_codes: [
          [201, '成功', V1::Entities::Address]
        ]
      params do
        requires :place, type: String, desc: "地址"
        requires :lat, type: String, desc: "纬度"
        requires :lon, type: String, desc: "经度"
        optional :name, type: String, desc: "名字"
        optional :note, type: String, desc: "备注"
        optional :address_type, type: String, desc: "类型：home,company,other，可不填，默认other"
      end
      post do
        address = current_user.addresses.new(permitted_params)
        address.application = current_application
        address.save
        present address, with: V1::Entities::Address
      end

      desc "编辑地址",
        headers: {
          "X-Access-Token" => {
            description: "Token",
            required: true
          },
        },
        http_codes: [
          [201, '成功', V1::Entities::Address]
        ]
      params do
        requires :id, type: Integer, desc: "地址编号"
        requires :place, type: String, desc: "地址"
        requires :lat, type: String, desc: "纬度"
        requires :lon, type: String, desc: "经度"
        optional :name, type: String, desc: "名字"
        optional :note, type: String, desc: "备注"
      end
      route_param :id do
        put do
          address = current_user.addresses.find(params[:id])
          address.update(permitted_params)
          present address, with: V1::Entities::Address
        end
      end

      desc "删除地址",
        headers: {
          "X-Access-Token" => {
            description: "Token",
            required: true
          },
        },
        http_codes: [
          [204, '成功']
        ]
      params do
        requires :id, type: Integer, desc: "汽车编号"
      end
      route_param :id do
        delete do
          address = current_user.addresses.find(params[:id])
          address.destroy
          status 204
          # { code: 0 }
        end
      end
    end
  end
end
