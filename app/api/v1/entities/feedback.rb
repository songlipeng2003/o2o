module V1
  module Entities
    class Feedback < Grape::Entity
      expose :id, documentation: { type: Integer, desc: '编号' }
      expose :feedback_type, documentation: { type: String, desc: '反馈类型， 1 返回,2 回复' }
      expose :content, documentation: { type: String, desc: '内容' }
    end
  end
end
