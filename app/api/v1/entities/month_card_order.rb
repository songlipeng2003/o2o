module V1
  module Entities
    class MonthCardOrder < Grape::Entity
      expose :id, documentation: { type: Integer, desc: '编号' }
      expose :system_month_card_id, documentation: { type: Integer, desc: '系统消费卡编号' }
      expose :car_id, documentation: { type: Integer, desc: '汽车编号' }
      expose :license_tag, documentation: { type: String, desc: '牌照' }
      expose :month, documentation: { type: Integer, desc: '月数' }
      expose :price, documentation: { type: Integer, desc: '价格' }
      expose :state, documentation: { type: Integer, desc: '状态' }
      expose :name, documentation: { type: String, desc: '名称' } do |month_card_order|
        month_card_order.system_month_card.name
      end
      expose :state_text, documentation: { type: String, desc: '状态文字' } do |month_card_order|
        month_card_order.aasm.human_state
      end
      expose :created_at, documentation: { type: String, desc: '创建时间' }
    end
  end
end
