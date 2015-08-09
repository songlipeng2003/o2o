module V1
  class Payments < Grape::API
    resource :payments do
      desc "支付方式列表", {
        http_codes: [
         [200, '成功', V1::Entities::OrderList]
        ]
      }
      params do
        requires :type, type: String, desc: "支付对象，目前可以传 product,recharge,month_card_order"
        optional :order_id, type: Integer, desc: '订单编号'
      end
      get do
        payemnts = current_application.payments
        if params[:order_id]
          order = Order.find(params[:order_id])

          if order.booked_at.hour >= 20
            payemnts = payemnts.where.not(code: 'balance')
          end
        end

        if params[:type]=='recharge' || params[:type]=='month_card_order'
          payemnts = payemnts.where.not(code: 'balance')
        end

        present payemnts, with: V1::Entities::Payment
      end
    end
  end
end
