module V1
  class Payments < Grape::API
    resource :payments do
      desc "支付方式列表"
      params do
        requires :type, type: String, desc: "支付对象，目前可以传 product,recharge,month_card_order"
      end
      get '/', http_codes: [
        [200, 'Ok', V1::Entities::Payment]
      ]  do
        payemnts = current_application.payments
        if params[:type]=='recharge' || params[:type]=='month_card_order'
          payemnts = payemnts.where.not(code: 'balance')
        end
        present payemnts, with: V1::Entities::Payment
      end
    end
  end
end
