module V1
  module Entities
    class Address < Grape::Entity
      expose :id
      expose :place
      expose :lat
      expose :lon
      expose :name
    end
  end
end
