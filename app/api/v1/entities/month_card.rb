module V1
  module Entities
    class MonthCard < Grape::Entity
      expose :id, documentation: { type: Integer, desc: '编号' }
      expose :license_tag, documentation: { type: String, desc: '牌照' }
      expose :started_at, documentation: { type: Time, desc: '开始时间' }
      expose :expired_at, documentation: { type: Time, desc: '过期时间' }
      expose :use_count, documentation: { type: Integer, desc: '使用次数' }
      expose :created_at, documentation: { type: Time, desc: '创建时间' }
    end
  end
end
