module StoreV1
  module Entities
    class StoreUser < Grape::Entity
      expose :id
      expose :username
      expose :phone
      expose :authentication_token
      expose :gender
      expose :nickname
      expose :store
    end
  end
end
