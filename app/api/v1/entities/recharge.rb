module V1
  module Entities
    class Recharge < Grape::Entity
      expose :id
      expose :user_id
      expose :amount
      expose :state
      expose :state_text do |recharge|
        recharge.aasm.human_state
      end
      expose :created_at
      expose :payed_at
    end
  end
end
