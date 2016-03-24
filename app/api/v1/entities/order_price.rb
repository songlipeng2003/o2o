module V1
  module Entities
    class OrderPrice < Grape::Entity
      expose :original_price, documentation: { type: Float, desc: '原价' }
      expose :total_amount, documentation: { type: Float, desc: '总价' }
      expose :order_amount, documentation: { type: Float, desc: '订单价格' }
      expose :service_ticket_id, documentation: { type: Integer, desc: '服务器编号' }
      expose :month_card_id, documentation: { type: Integer, desc: '消费卡编号' }
    end
  end
end
