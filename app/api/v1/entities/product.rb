module V1
  module Entities
    class Product < Grape::Entity
      expose :id
      expose :name
      expose :market_price
      expose :suv_price
      expose :price
      expose :description
      expose :image do |product|
        product.image.thumb.url
      end
    end
  end
end
