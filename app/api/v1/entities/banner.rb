module V1
  module Entities
    class Banner < Grape::Entity
      expose :image, documentation: { type: String, desc: '图片' } do |instance, options|
        instance.image.url
      end
      expose :link, documentation: { type: String, desc: '链接' }
    end
  end
end
