module Entities
  class Banner < Grape::Entity
    expose :image do |instance, options|
      instance.image.url
    end
    expose :link
  end
end
