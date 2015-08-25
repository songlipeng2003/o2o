ActiveAdmin.register Feedback do
  actions :index, :show, :destroy

  index do
    selectable_column
    id_column
    column :user
    column :feedback_type do |feedback|
      Feedback::FEEDBACK_TYPES[feedback.feedback_type]
    end
    column :content
    column :application
    column :created_at
    actions defaults: true do |feedback|
      link = ''
      link << link_to('回复', reply_admin_feedback_path(feedback))

      raw link
    end
  end

  filter :user_phone, :as => :string
  filter :title
  filter :content
  filter :created_at
  filter :updated_at

  member_action :reply, method: [:get, :post] do
    @feedback = Feedback::find(params[:id])
    @reply = Feedback.new

    if request.post? || request.patch?
      @reply.user_id = @feedback.user_id
      @reply.content = params[:feedback][:content]
      @reply.feedback_type = Feedback::FEEDBACK_TYPE_REPLY
      @reply.application = Application.find_by name: '后台'
      if @reply.save
        redirect_to admin_feedback_path, notice: "回复成功"
      end
    end

    @page_title = "反馈回复"
  end
end
