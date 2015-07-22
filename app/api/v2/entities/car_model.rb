module V1
  module Entities
    class CarModelCarBrand < Grape::Entity
      expose :id
      expose :name
    end

    class CarModel < Grape::Entity
      expose :id
      expose :name
      expose :car_brand, using: V1::Entities::CarModelCarBrand
    end
  end
end
