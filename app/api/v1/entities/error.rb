module V1
  module Entities
    class Error < Grape::Entity
      expose :message, documentation: { type: String, desc: '信息' }
    end
  end
end
