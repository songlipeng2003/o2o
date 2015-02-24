module V1
  module Entities
    class Coupon < Grape::Entity
      expose :id
      expose :amount
      expose :state
      expose :count
      expose :state_text do |coupon|
        coupon.aasm.human_state
      end
      expose :expired_at
      expose :image do |coupon|
        coupon.system_coupon.image.thumb.url
      end
      expose :name do |coupon|
        coupon.system_coupon.name
      end
      expose :product_id do |coupon|
        coupon.system_coupon.product_id
      end
      expose :description do |coupon|
        coupon.system_coupon.description
      end
      expose :created_at
    end
  end
end
