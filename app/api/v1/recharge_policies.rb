module V1
  class RechargePolicies < Grape::API

    resource :recharge_policies do
      desc "充值策略列表"
      get do
        present RechargePolicy.all
      end
    end
  end
end
