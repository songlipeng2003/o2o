module V1
  module Entities
    class SystemProduct < Grape::Entity
      expose :id
      expose :name
      expose :description
      expose :image do |product|
        product.image.thumb.url
      end
    end
  end
end
