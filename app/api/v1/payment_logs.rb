module V1
  class PaymentLogs < Grape::API
    before do
      error!("401 Unauthorized", 401) unless authenticated
    end

    resource :payment_logs do
      desc "支付流水",
        headers: {
          "X-Access-Token" => {
            description: "Token",
            required: true
          },
        },
        is_array: true,
        entity: V1::Entities::PaymentLog
      params do
        requires :id, type: Integer, desc: "支付记录编号"
      end
      route_param :id do
        get do
          payment_log =  PaymentLog.find(params[:id])
          error!("404 Not Found", 404) unless payment_log.item.user_id == current_user.id
          present payment_log, with: V1::Entities::PaymentLog
        end
      end

      desc "余额支付",
        headers: {
          "X-Access-Token" => {
            description: "Token",
            required: true
          },
        },
        http_codes: [
         [201, '成功', V1::Entities::PaymentLog]
        ]
      params do
        requires :id, type: Integer, desc: "支付流水编号"
        requires :pay_password, type: String, desc: "支付密码"
      end
      route_param :id do
        put 'pay' do
          payment_log = PaymentLog.find(params[:id])
          error!("404 Not Found", 404) unless payment_log.item.user_id == current_user.id
          error!("404 Not Found", 404) unless payment_log.unpayed? || payment_log.payment.code !='balance'
          if current_user.encrypted_pay_password.blank?
            return {
              code: -1,
              msg: '未设置支付密码'
            }
          end

          if !current_user.validate_pay_password(params[:pay_password])
            return {
              code: -2,
              msg: '支付密码错误'
            }
          end

          if current_user.balance<payment_log.amount
            return {
              code: -3,
              msg: '余额不足'
            }
          end

          payment_log.pay!

          present payment_log, with: V1::Entities::PaymentLog
        end
      end
    end
  end
end
