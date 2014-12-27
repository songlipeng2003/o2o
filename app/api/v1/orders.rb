module V1
  class Orders < Grape::API
    before do
      error!("401 Unauthorized", 401) unless authenticated
    end

    resource :orders do
      desc "订单"
      params do
        optional :page, type: Integer, desc: "页码"
      end
      get do

      end

      desc "订单详情"
      params do
        requires :id, type: Integer, desc: "ID"
      end
      route_param :id do
        get do
        end
      end

      desc "重发短信接口"
      params do
        requires :id, type: Integer, desc: "ID"
      end
      route_param ':id/re_send_sms' do
        get do
        end
      end

      desc "生成订单"
      params do
        requires :phone, type: String, desc: "手机"
        requires :car_id, type: Integer, desc: "汽车编号"
        requires :address, type: String, desc: "地址"
        requires :book_at, type: String, desc: "预约时间"
        requires :note, type: String, desc: "订单备注"
        requires :lon, type: Float, desc: "经度"
        requires :lat, type: Float, desc: "纬度"
      end
      post do

      end
    end
  end
end
