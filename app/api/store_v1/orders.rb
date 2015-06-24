module StoreV1
  class Orders < Grape::API
    helpers do
      def order_collection
        if current_user.username == 'zhaocuihong'
          Order.with_deleted
        else
          if current_user.role == StoreUser::ROLE_LEADER
            current_store.orders.with_deleted
          else
            current_user.orders.with_deleted
          end
        end
      end
    end

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
        if params[:state].blank?
          orders = order_collection.where.not(state: 'unpayed')
        else
          orders = order_collection.where(state: params[:state])
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
          order = order_collection.find(params[:id])
          present order, with: V1::Entities::Order
        end
      end

      desc "确认订单", {
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
        put :confirm do
          order = order_collection.find(params[:id])
          order.confirm(current_user)
          order.save
          present order, with: StoreV1::Entities::OrderList
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
          order = order_collection.find(params[:id])
          order.finish(current_user)
          order.save
          present order, with: StoreV1::Entities::OrderList
        end
      end

      desc "切换订单商户", {
        headers: {
          "X-Access-Token" => {
            description: "Token",
            required: true
          },
        }
      }
      params do
        requires :id, type: Integer, desc: "订单编号"
        requires :store_user_id, type: Integer, desc: "商户编号"
      end
      route_param :id do
        put :change_user do
          order = order_collection.find(params[:id])
          store_user = StoreUser.find(params[:store_user_id])
          order.change_store_user!(params[:store_user_id])
          present order, with: StoreV1::Entities::OrderList
        end
      end
    end
  end
end
