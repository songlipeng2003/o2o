module V1
  module Entities
    class Coupon < Grape::Entity
      expose :id, documentation: { type: Integer, desc: '编号' }
      expose :amount, documentation: { type: Integer, desc: '金额' }
      expose :state, documentation: { type: String, desc: '状态' }
      expose :count, documentation: { type: Integer, desc: '数量' }
      expose :state_text, documentation: { type: String, desc: '状态文字' } do |coupon|
        coupon.aasm.human_state
      end
      expose :expired_at, documentation: { type: String, desc: '过期时间' }
      expose :image, documentation: { type: String, desc: '图片' } do |coupon|
        coupon.system_coupon.image.thumb.url
      end
      expose :name, documentation: { type: String, desc: '名称' } do |coupon|
        coupon.system_coupon.name
      end
      expose :product_id, documentation: { type: Integer, desc: '产品编号' } do |coupon|
        coupon.system_coupon.product_id
      end
      expose :description, documentation: { type: Integer, desc: '描述' } do |coupon|
        coupon.system_coupon.description
      end
      expose :created_at, documentation: { type: String, desc: '创建时间' }
    end
  end
end
