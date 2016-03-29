module V1
  module Entities
    class Order < Grape::Entity
      expose :id, documentation: { type: Integer, desc: '编号' }
      expose :sn, documentation: { type: String, desc: '订单号' }
      expose :car_model_id, documentation: { type: String, desc: '车型编号' }
      expose :car_model_name, documentation: { type: String, desc: '车型名称' }
      expose :car_color, documentation: { type: String, desc: '汽车颜色' }
      expose :license_tag, documentation: { type: String, desc: '车牌' }
      expose :phone, documentation: { type: String, desc: '手机号' }
      expose :place, documentation: { type: String, desc: '地址' }
      expose :lat, documentation: { type: Float, desc: '纬度' }
      expose :lon, documentation: { type: Float, desc: '经度' }
      expose :carport, documentation: { type: String, desc: '车库' }
      expose :is_underground_park, documentation: { type: 'boolean', desc: '是否在地下车库' }
      expose :is_include_interior, documentation: { type: 'boolean', desc: '是否包含内饰' }
      expose :product_type, documentation: { type: Integer, desc: '商品类型' }
      expose :product_type_text, documentation: { type: String, desc: '车牌' }
      expose :note, documentation: { type: String, desc: '备注' }
      expose :original_price, documentation: { type: Float, desc: '原价' }
      expose :total_amount, documentation: { type: Float, desc: '总价' }
      expose :booked_at, documentation: { type: String, desc: '预定时间' }
      expose :created_at, documentation: { type: String, desc: '下单时间' }
      expose :state, documentation: { type: String, desc: '状态' }
      expose :state_text, documentation: { type: String, desc: '状态文字' } do |order|
        order.aasm.human_state
      end

      expose :evaluation, using: V1::Entities::Evaluation, documentation: { type: 'V1::Entities::Evaluation', desc: '评价' }

      expose :links do |order|
        links = []
        links << { rel: 'pay', link: "v1/orders/#{order.id}/pay" } if order.unpayed?
        links << { rel: 'close', link: "v1/orders/#{order.id}/close" } if order.unpayed? || order.payed?
        links << { rel: 'evaluate', link: "v1/orders/#{order.id}/evaluate" } if order.finished?
        links
      end

      expose :store_user, using: V1::Entities::StoreUser, documentation: { type: 'V1::Entities::StoreUser', desc: '服务人员' }

      expose :order_type, documentation: { type: Integer, desc: '订单类型,1为上门洗车订单，2为洗车机订单' }

      expose :wash_machine_id, documentation: { type: Integer, desc: '洗车机编号' }
      expose :wash_machine_name, documentation: { type: String, desc: '洗车机名称' } do |order|
        order.wash_machine ? order.wash_machine.name : nil
      end
      expose :wash_machine_set_id, documentation: { type: Integer, desc: '洗车机套餐编号' }
      expose :wash_machine_set_name, documentation: { type: String, desc: '洗车机套餐名称' } do |order|
        order.wash_machine_set ? order.wash_machine_set.name : nil
      end

      expose :wash_machine_encrypt_code, documentation: { type: Integer, desc: '洗车机套餐编号' } do |order|
        '123456'
      end
    end
  end
end
