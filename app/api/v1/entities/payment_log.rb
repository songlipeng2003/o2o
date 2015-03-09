module V1
  module Entities
    class PaymentLog < Grape::Entity
      expose :id, documentation: { type: Integer, desc: '编号' }
      expose :name, documentation: { type: String, desc: '名称' }
      expose :amount
      expose :state
      expose :state_text do |payment_log|
        payment_log.aasm.human_state
      end
      expose :created_at
      expose :redirect_url do |payment_log|
        if payment_log.payment.code=='alipay_wap'
          options = {
            :req_data => {
              :out_trade_no  => payment_log.id,
              :subject       => payment_log.name,
              :total_fee     => payment_log.amount,
              :notify_url    => 'http://24didi.com/pay/alipay_wap_notify',
              :call_back_url => 'http://m.24didi.com' # TODO 跳转URL
            }
          }

          token = Alipay::Service::Wap.trade_create_direct_token(options)
          Alipay::Service::Wap.auth_and_execute(request_token: token)
        end
      end
    end
  end
end
