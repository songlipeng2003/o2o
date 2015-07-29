module V1
  module Entities
    class Store < Grape::Entity
      expose :id
      expose :name
      expose :address
      expose :description
      expose :good_rate
      expose :collect_count
      expose :score
      expose :created_at
    end
  end
end
