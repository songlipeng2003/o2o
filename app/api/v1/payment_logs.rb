module V1
  class PaymentLogs < Grape::API
    resource :payment_logs do
      desc "支付流水"
      params do
        requires :id, type: Integer, desc: "支付记录编号"
      end
      route_param :id do
        get do
          payment_log =  Payment.find(params[:id])
          present payment_log, with: V1::Entities::PaymentLog
        end
      end
    end
  end
end
