module V1
  module Entities
    class User < Grape::Entity
      expose :id
      expose :email
      expose :phone
      expose :balance
      expose :score
      expose :avatar do |instance|
        instance.avatar.url
      end
      expose :gender
      expose :nickname
      expose :authentication_token
    end
  end
end
