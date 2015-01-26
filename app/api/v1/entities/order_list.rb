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

      expose :links do |order|
        links = []
        links << { rel: 'pay', link: "v1/orders/#{order.id}/pay" } if order.unpayed?
        links << { rel: 'evaluate', link: "v1/orders/#{order.id}/evaluate" } if order.finished?
        links
      end
    end
  end
end
