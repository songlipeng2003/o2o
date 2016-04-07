module V2
  module Entities
    class Error < Grape::Entity
      expose :code, documentation: { type: Integer, desc: '状态码' }
      expose :message, documentation: { type: String, desc: '信息' }
    end
  end
end
