module StoreV1
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
        orders = paginate current_store.orders.where.not(state: 'unpayed')
        present orders, with: V1::Entities::OrderList
      end

      desc "订单完成", {
        headers: {
          "X-Access-Token" => {
            description: "Token",
            required: true
          },
        }
      }
      params do
        requires :id, type: Integer, desc: "订单编号"
      end
      route_param :id do
        post :finish do
          order = current_store.orders.find(params[:id])
          order.finish
          order.save
          present order, with: V1::Entities::OrderList
        end
      end
    end
  end
end
