module V1
  module Entities
    class WashMachine < Grape::Entity
      expose :id, documentation: { type: Integer, desc: '编号' }
      expose :name, documentation: { type: String, desc: '名字' }
      expose :code, documentation: { type: String, desc: '机器码' }
      expose :address, documentation: { type: String, desc: '地址' }
      expose :score, documentation: { type: String, desc: '分数' }
    end
  end
end
