module V1
  module Entities
    class Coupon < Grape::Entity
      expose :id
      expose :amount
      expose :state
      expose :expired_at
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
