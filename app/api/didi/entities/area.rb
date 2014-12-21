module Didi
  module Entities
    class Area < Grape::Entity
      expose :name
      expose :children
    end
  end
end
