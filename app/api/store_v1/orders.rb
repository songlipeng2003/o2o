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
        optional :state, type: String, desc: '订单状态'
      end
      paginate per_page: 10
      get do
        if current_user.username == 'zhaocuihong'
          orders = Order.with_deleted
        else
          orders = current_store.orders.with_deleted
        end

        if params[:state].blank?
          orders = orders.where.not(state: 'unpayed')
        else
          orders = orders.where(state: params[:state])
        end
        orders = orders.order('booked_at DESC')
        orders = paginate orders
        present orders, with: StoreV1::Entities::OrderList
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
        requires :id, type: Integer, desc: "订单编号"
      end
      route_param :id do
        get do
          present current_store.orders.with_deleted.find(params[:id]), with: V1::Entities::Order
        end
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
        put :finish do
          if current_user.username == 'zhaocuihong'
            orders = Order.with_deleted
          else
            orders = current_store.orders.with_deleted
          end
          order = orders.find(params[:id])
          order.finish(current_user)
          order.save
          present order, with: StoreV1::Entities::OrderList
        end
      end
    end
  end
end
