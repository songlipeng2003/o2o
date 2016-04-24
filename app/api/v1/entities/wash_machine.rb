module V1
  module Entities
    class WashMachine < Grape::Entity
      expose :id, documentation: { type: Integer, desc: '编号' }
      expose :name, documentation: { type: String, desc: '名字' }
      expose :code, documentation: { type: String, desc: '机器码' }
      expose :address, documentation: { type: String, desc: '地址' }
      expose :score, documentation: { type: Float, desc: '分数' }
      expose :orders_count, documentation: { type: Integer, desc: '订单数' }
    end
  end
end
