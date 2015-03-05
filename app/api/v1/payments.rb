module V1
  class Payments < Grape::API
    resource :payments do
      desc "支付方式列表"
      get do
        payemnts = current_application.payments
        present payemnts, with: V1::Entities::Payment
      end
    end
  end
end
