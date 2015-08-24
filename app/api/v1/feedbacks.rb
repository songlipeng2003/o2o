module V1
  class Feedbacks < Grape::API
    before do
      error!("401 Unauthorized", 401) unless authenticated
    end

    resource :feedbacks do
      desc "添加反馈",
        headers: {
          "X-Access-Token" => {
            description: "Token",
            required: true
          },
        },
        http_codes: [
          [201, '成功', V1::Entities::Feedback]
        ]
      params do
        requires :title, type: String, desc: "地址"
        requires :feedback_type, type: String, desc: "纬度"
        requires :content, type: String, desc: "经度"
      end
      post do
        feedback = current_user.feedbacks.new(permitted_params)
        feedback.application = current_application
        feedback.save
        present feedback, with: V1::Entities::Feedback
      end
    end
  end
end
