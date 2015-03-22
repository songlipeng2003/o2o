module V1
  module Entities
    class Order < Grape::Entity
      expose :id
      expose :sn
      # expose :store, using: V1::Entities::Store
      expose :car_model_id
      expose :car_model_name
      expose :car_color
      expose :license_tag
      expose :phone
      expose :place
      expose :lat
      expose :lon
      expose :carport
      expose :is_underground_park
      expose :is_include_interior
      expose :product_type_text
      expose :note
      expose :original_price
      expose :total_amount
      expose :booked_at
      expose :created_at
      expose :state
      expose :state_text do |order|
        order.aasm.human_state
      end

      expose :evaluation, using: V1::Entities::Evaluation

      expose :links do |order|
        links = []
        links << { rel: 'pay', link: "v1/orders/#{order.id}/pay" } if order.unpayed?
        links << { rel: 'close', link: "v1/orders/#{order.id}/close" } if order.unpayed? || order.payed?
        links << { rel: 'evaluate', link: "v1/orders/#{order.id}/evaluate" } if order.finished?
        links
      end

    end
  end
end
