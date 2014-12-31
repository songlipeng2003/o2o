module V1
  module Entities
    class CarBrandCarModel < Grape::Entity
      expose :id
      expose :first_letter
      expose :name
    end

    class CarBrand < Grape::Entity
      expose :id
      expose :first_letter
      expose :name
      expose :car_models, using: V1::Entities::CarBrandCarModel
    end
  end
end
