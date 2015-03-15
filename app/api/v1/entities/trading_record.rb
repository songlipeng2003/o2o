module V1
  module Entities
    class TradingRecord < Grape::Entity
      expose :id, documentation: { type: Integer, desc: '编号' }
      expose :name, documentation: { type: String, desc: '名称' }
      expose :trading_type, documentation: { type: Integer, desc: '交易类型' }
      expose :trading_type_name, documentation: { type: String, desc: '交易类型名称' }
      expose :amount, documentation: { type: Float, desc: '金额' }
      expose :start_amount, documentation: { type: Float, desc: '起始金额' }
      expose :end_amount, documentation: { type: Float, desc: '结束金额' }
      expose :remark, documentation: { type: String, desc: '备注' }
      expose :created_at, documentation: { type: Time, desc: '创建时间' }
    end
  end
end
