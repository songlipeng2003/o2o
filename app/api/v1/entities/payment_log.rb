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
    end
  end
end
