module Didi
  module Entities
    class DocList < Grape::Entity
      expose :title
      expose :key
    end
  end
end
