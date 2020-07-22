module V1
  class Feedbacks < Grape::API
    before do
      error!("401 Unauthorized", 401) unless authenticated
    end

    resource :feedbacks do
      desc "反馈列表",
        is_array: true,
        entity: V1::Entities::Feedback
      params do
        optional 'X-Access-Token', type: String, desc: 'Token', documentation: { in: :header }
      end
      get do
        present current_user.feedbacks.order('id DESC, id DESC').all, with: V1::Entities::Feedback
      end

      desc "添加反馈"
      params do
        optional 'X-Access-Token', type: String, desc: 'Token', documentation: { in: :header }
        requires :content, type: String, desc: "经度"
      end
      post do
        safe_params = clean_params(params).permit(:content)
        feedback = current_user.feedbacks.new(safe_params)
        feedback.application = current_application
        feedback.feedback_type = Feedback::FEEDBACK_TYPE_FEEDBACK
        feedback.save
        present feedback, with: V1::Entities::Feedback
      end
    end
  end
end
