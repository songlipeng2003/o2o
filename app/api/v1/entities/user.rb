module V1
  module Entities
    class User < Grape::Entity
      expose :id
      expose :email
      expose :phone
      expose :balance
      expose :score
      expose :avatar do |instance|
        if instance.avatar.attached?
          store_user.avatar
        end
      end
      expose :gender
      expose :nickname
      expose :authentication_token
      expose :is_set_pay_password
    end
  end
end
