module V1
  module Entities
    class OrderList < Grape::Entity
      expose :id
      expose :store, using: V1::Entities::Store
      expose :car
      expose :phone
      expose :address
      expose :lat
      expose :lon
      expose :booked_at
      expose :note
      expose :created_at
      expose :state
      expose :state_text do |order|
        order.aasm.human_state
      end
    end
  end
end
