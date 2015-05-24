module V1
  class MonthCardOrders < Grape::API
    before do
      error!("401 Unauthorized", 401) unless authenticated
    end

    resource :month_card_orders do
      desc "创建月卡订单", {
        headers: {
          "X-Access-Token" => {
            description: "Token",
            required: true
          },
        }
      }
      params do
        optional :system_month_card_id, type: Integer, desc: "系统月卡编号"
        optional :car_id, type: Integer, desc: "汽车编号"
      end
      post do
        car = current_user.cars.find(params[:car_id])

        month_card_order = current_user.month_card_orders.new(permitted_params)
        month_card_order.application = current_application
        month_card_order.car = car
        month_card_order.save
        present month_card_order, with: V1::Entities::MonthCardOrder
      end

      desc "选择支付方式", {
        headers: {
          "X-Access-Token" => {
            description: "Token",
            required: true
          },
        }
      }
      params do
        requires :id, type: Integer, desc: "月卡订单编号"
        requires :payment_id, type: Integer, desc: "支付编号"
        optional :open_id, type: String, desc: "OpenId, 微信公众号支付时需要"
      end
      route_param :id do
        post :payment do
          month_card_order = current_user.month_card_orders.find(params[:id])
          error!("404 Not Found", 404) unless month_card_order.unpayed?
          payment = Payment.find(params[:payment_id])
          payment_log = month_card_order.payment_logs.where(payment_id: params[:payment_id]).order('id DESC').first
          unless payment_log && payment_log.unpayed?
            payment_log = month_card_order.payment_logs.build({
              payment: payment,
              name: "#{month_card_order.month}个月月卡订单",
              amount: month_card_order.price
            })
            payment_log.application = current_application
            payment_log.save
          end

          payment_log.extras = { open_id: params[:open_id] } unless params[:open_id].blank?

          present payment_log, with: V1::Entities::PaymentLog
        end
      end
    end
  end
end
