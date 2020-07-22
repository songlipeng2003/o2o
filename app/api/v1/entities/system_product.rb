module V1
  module Entities
    class SystemProduct < Grape::Entity
      expose :id
      expose :category_id
      expose :category_name do |system_product|
        system_product.category.name
      end
      expose :name
      expose :description
      expose :image do |product|
        product.image.thumb.url
      end
    end
  end
end
