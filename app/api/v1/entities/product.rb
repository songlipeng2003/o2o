module V1
  module Entities
    class Product < Grape::Entity
      expose :id, documentation: { type: Integer, desc: '编号' }
      expose :name, documentation: { type: String, desc: '名称' }
      expose :market_price, documentation: { type: Float, desc: '市场价' }
      expose :suv_price, documentation: { type: Float, desc: 'SUV价格' }
      expose :price, documentation: { type: Float, desc: '轿车价格' }
      expose :description, documentation: { type: String, desc: '描述' }
      expose :image, documentation: { type: String, desc: '图片' } do |product|
        product.image.thumb.url
      end
    end
  end
end
