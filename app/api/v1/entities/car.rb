module V1
  module Entities
    class Car < Grape::Entity
      expose :id
      expose :car_model_id
      expose :car_model_name
      expose :license_tag
      expose :color
      expose :created_at
    end
  end
end
