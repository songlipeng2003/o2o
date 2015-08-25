module V1
  module Entities
    class Feedback < Grape::Entity
      expose :id, documentation: { type: Integer, desc: '编号' }
      expose :feedback_type, documentation: { type: String, desc: '反馈类型， 1 bug,2 建议, 3 改进' }
      expose :title, documentation: { type: String, desc: '标题' }
      expose :content, documentation: { type: String, desc: '内容' }
    end
  end
end
