module V1
  class Recharges < Grape::API
    before do
      error!("401 Unauthorized", 401) unless authenticated
    end

    resource :recharges do
      desc "充值记录", {
        headers: {
          "X-Access-Token" => {
            description: "Token",
            required: true
          },
        }
      }
      paginate
      get do
        recharges =  paginate current_user.recharges
        present recharges, with: V1::Entities::Recharge
      end

      desc "充值", {
        headers: {
          "X-Access-Token" => {
            description: "Token",
            required: true
          },
        }
      }
      params do
        optional :amount, type: Integer, desc: "金额,金额和充值策略只能选择一个，选择金额充值不会有任何优惠活动，只有选择充值策略的时候，才会有返现和赠送代金券"
        optional :recharge_policy_id, type: Integer, desc: "充值策略"
        mutually_exclusive :amount, :recharge_policy_id
      end
      post do
        recharge = current_user.recharges.new(permitted_params)
        recharge.application = current_application
        recharge.save
        present recharge, with: V1::Entities::Recharge
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
        requires :id, type: Integer, desc: "充值编号"
        requires :payment_id, type: Integer, desc: "支付编号"
        optional :open_id, type: String, desc: "OpenId, 微信公众号支付时需要"
      end
      route_param :id do
        post :payment do
          recharge = current_user.recharges.find(params[:id])
          error!("404 Not Found", 404) unless recharge.unpayed?
          payment = Payment.find(params[:payment_id])
          if payment.payment_type == 'balance'
            error!("404 Not Found", 404)
          end
          payment_log = recharge.payment_logs.where(payment_id: params[:payment_id]).order('id DESC').first
          unless payment_log && payment_log.unpayed?
            payment_log = recharge.payment_logs.build({
              payment: payment,
              name: "充值#{recharge.amount}元",
              amount: recharge.amount
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
