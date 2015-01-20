module V1
  class Orders < Grape::API
    before do
      error!("401 Unauthorized", 401) unless authenticated
    end

    resource :orders do
      desc "订单", {
        headers: {
          "X-Access-Token" => {
            description: "Token",
            required: true
          },
        }
      }
      params do
        optional :page, type: Integer, desc: "页码"
        optional :per_page, type: Integer, desc: '每页数量'
      end
      paginate per_page: 10
      get do
        orders = paginate current_user.orders
        present orders, with: V1::Entities::Order
      end

      desc "计算订单价格接口", {
        headers: {
          "X-Access-Token" => {
            description: "Token",
            required: true
          },
        }
      }
      params do
        requires :car_model_id, type: Integer, desc: "车型ID"
        requires :is_include_interior, type: Boolean, desc: "是否包含内饰"
      end
      get :price do
        price = 15
        {
          price: price
        }
      end

      desc "订单详情", {
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
          present current_user.orders.find(params[:id]), with: V1::Entities::Order
        end
      end

      desc "检查交易时间", {
        headers: {
          "X-Access-Token" => {
            description: "Token",
            required: true
          },
        }
      }
      params do
        requires :booked_at, type: String, desc: "预定时间"
        requires :store_ids, type: String, desc: "商户id，使用英文，分隔"
      end
      route_param ':id/re_send_sms' do
        patch do
          {
            code: 0
          }
        end
      end

      desc "重发短信接口", {
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
      route_param ':id/re_send_sms' do
        patch do
        end
      end

      desc "生成订单", {
        headers: {
          "X-Access-Token" => {
            description: "Token",
            required: true
          },
        }
      }
      params do
        requires :phone, type: String, desc: "手机"
        requires :store_id, type: Integer, desc: "商户编号"
        optional :car_id, type: Integer, desc: "汽车编号,汽车编号和汽车详情仅需填写一个"
        optional :car, type: Hash do
          optional :car_model_id, type: Integer, desc: "汽车型号编号"
          optional :color, type: String, desc: "汽车颜色"
          optional :license_tag, type: String, desc: "车牌号"
        end
        mutually_exclusive :car_id, :car
        optional :address_id, type: Integer, desc: "地址编号,地址编号喝地址信息仅需填写一个"
        optional :address, type: Hash do
          optional :place, type: String, desc: "地址"
          optional :lon, type: String, desc: "经度"
          optional :lat, type: String, desc: "纬度"
        end
        mutually_exclusive :address, :address_id
        requires :booked_at, type: String, desc: "预约时间"
        optional :product_id, type: Integer, desc: "商品编号，默认为1标准洗车"
        optional :is_underground_park, type: Boolean, desc: "是否在地下停车库"
        optional :carport, type: String, desc: "车位号"
        optional :note, type: String, desc: "订单备注"
      end
      post do
        order current_user.orders.new(permitted_params)
        unless permitted_params[:car].blank?
          car = Car.new(permitted_params[:car])
          car.save
          order.car_id = car.id
        end

        unless permitted_params[:address].blank?
          address = Address.new(permitted_params[:address])
          address.save
          order.address_id = address.id
        end

        present order.save
      end

      desc "评价", {
        headers: {
          "X-Access-Token" => {
            description: "Token",
            required: true
          },
        }
      }
      params do
        requires :id, type: Integer, desc: "ID"
        requires :evaluate, type: Integer, desc: '评价，1-5'
        optional :note, type: String, desc: '备注'
        optional :images, type: String, desc: '图片'
      end
      route_param ':id/evaluate' do
        patch do
        end
      end
    end
  end
end
