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
        optional :amount, type: Integer, desc: "金额,和充值策略只能选择一个"
        optional :recharge_policy_id, type: Integer, desc: "充值策略"
        mutually_exclusive :amount, :recharge_policy_id
      end
      post do
        recharge = current_user.recharges.new(permitted_params)
        recharge.application = current_application
        recharge.save
        present recharge, with: V1::Entities::Recharge
      end

      desc "充值成功，仅为测试，后面删除", {
        headers: {
          "X-Access-Token" => {
            description: "Token",
            required: true
          },
        }
      }
      params do
        requires :id, type: Integer, desc: "ID"
      end
      route_param :id do
        get 'pay' do
          recharge = current_user.recharges.find(params[:id])
          recharge.pay
          present recharge.save
        end
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
      end
      route_param :id do
        post :payment do
          recharge = current_user.recharges.find(params[:id])
          error!("404 Not Found", 404) unless recharge.unpayed?
          payment = Payment.find(params[:payment_id])
          payment_log = recharge.payment_logs.where(payment_id: params[:payment_id]).order('id DESC').first
          unless payment_log && payment_log.unpayed?
            payment_log = recharge.payment_logs.build({
              payment: payment,
              name: '充值#{recharge.amount}'
            })
            payment_log.application = current_application
            payment_log.save
          end

          present payment_log
        end
      end
    end
  end
end
