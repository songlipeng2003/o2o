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
        requires :amount, type: Integer, desc: "金额"
      end
      post do
        present current_user.recharges.create(permitted_params), with: V1::Entities::Recharge
      end
    end
  end
end
