module Didi
  module Entities
    class CarModelList < Grape::Entity
      expose :id
      expose :name
      expose :car_brand_id
      expose :car_brand_name
    end
  end
end
