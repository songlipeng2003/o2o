module V1
  module Entities
    class MonthCardOrder < Grape::Entity
      expose :id
      expose :system_month_card_id
      expose :car_id
      expose :month
      expose :price
      expose :state_text do |recharge|
        recharge.aasm.human_state
      end
      expose :created_at
    end
  end
end
