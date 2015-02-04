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
    end
  end
end
