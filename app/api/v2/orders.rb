module V2
  class Orders < Grape::API
    before do
      error!("401 Unauthorized", 401) unless authenticated
    end

    resource :orders do
      desc "选择支付方式", {
        headers: {
          "X-Access-Token" => {
            description: "Token",
            required: true
          },
        },
        http_codes: [
          [404, 'Not Found', V2::Entities::Error],
          [401, 'Unauthorized', V2::Entities::Error],
          [200, 'Ok', V2::Entities::PaymentLog]
        ]
      }
      params do
        requires :id, type: Integer, desc: "订单编号"
        requires :payment_id, type: Integer, desc: "支付编号"
        optional :open_id, type: String, desc: "OpenId, 微信公众号支付时需要"
      end
      route_param :id do
        post :payment do
          order = current_user.orders.find(params[:id])
          error!("404 Not Found", 404) unless order.unpayed?
          payment = Payment.find(params[:payment_id])
          payment_log = order.payment_logs.where(payment_id: params[:payment_id]).order('id DESC').first
          unless payment_log && payment_log.unpayed?
            payment_log = order.payment_logs.build({
              payment: payment,
              name: order.product.name,
              amount: order.total_amount
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
