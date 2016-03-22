module V1
  module Entities
    class Recharge < Grape::Entity
      expose :id, documentation: { type: Integer, desc: '编号' }
      expose :amount, documentation: { type: Integer, desc: '金额' }
      expose :state, documentation: { type: String, desc: '状态' }
      expose :state_text, documentation: { type: String, desc: '状态文字' } do |recharge|
        recharge.aasm.human_state
      end
      expose :created_at, documentation: { type: String, desc: '创建时间' }
      expose :payed_at, documentation: { type: String, desc: '付款时间' }
    end
  end
end
