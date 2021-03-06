module V1
  class Recharges < Grape::API
    before do
      error!("401 Unauthorized", 401) unless authenticated
    end

    resource :recharges do
      desc "充值记录", {
        is_array: true,
        entity: V1::Entities::Recharge
      }
      paginate
      params do
        optional 'X-Access-Token', type: String, desc: 'Token', documentation: { in: :header }
      end
      get do
        recharges =  paginate current_user.recharges
        present recharges, with: V1::Entities::Recharge
      end

      desc "充值", {
        http_codes: [
         [201, '成功', V1::Entities::Recharge]
        ]
      }
      params do
        optional 'X-Access-Token', type: String, desc: 'Token', documentation: { in: :header }
        optional :amount, type: Integer, desc: "金额,金额和充值策略只能选择一个，选择金额充值不会有任何优惠活动，只有选择充值策略的时候，才会有返现和赠送代金券"
        optional :recharge_policy_id, type: Integer, desc: "充值策略"
        mutually_exclusive :amount, :recharge_policy_id
      end
      post do
        safe_params = clean_params(params).permit(:amount, :recharge_policy_id, :amount)
        recharge = current_user.recharges.new(safe_params)
        recharge.application = current_application
        recharge.save
        present recharge, with: V1::Entities::Recharge
      end

      desc "选择支付方式", {
        http_codes: [
         [201, '成功', V1::Entities::PaymentLog]
        ]
      }
      params do
        optional 'X-Access-Token', type: String, desc: 'Token', documentation: { in: :header }
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
