module V1
  module Entities
    class StoreUser < Grape::Entity
      expose :id, documentation: { type: Integer, desc: '编号' }
      expose :phone, documentation: { type: String, desc: '手机号' }
      expose :nickname, documentation: { type: String, desc: '昵称' }
      expose :orders_count, documentation: { type: Integer, desc: '订单数' }
      expose :score, documentation: { type: Float, desc: '得分' }
      expose :avatar, documentation: { type: String, desc: '头像' } do |instance|
        instance.avatar.url
      end
    end
  end
end
