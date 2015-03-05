module V1
  module Entities
    class Payment < Grape::Entity
      expose :id
      expose :name
      expose :code
    end
  end
end
