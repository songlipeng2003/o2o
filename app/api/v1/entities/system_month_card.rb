module V1
  module Entities
    class SystemMonthCard < Grape::Entity
      expose :id, documentation: { type: Integer, desc: '编号' }
      expose :name, documentation: { type: String, desc: '名称' }
      expose :month, documentation: { type: Integer, desc: '月份' }
      expose :price, documentation: { type: Integer, desc: '价格' }
    end
  end
end
