module StoreV1
  module Entities
    class StoreUserList < Grape::Entity
      expose :id
      expose :nickname
    end
  end
end
