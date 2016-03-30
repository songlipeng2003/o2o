module V1
  module Entities
    class WashMachine < Grape::Entity
      expose :id, documentation: { type: Integer, desc: '编号' }
      expose :code, documentation: { type: String, desc: '机器码' }
      expose :address, documentation: { type: String, desc: '地址' }
    end
  end
end
