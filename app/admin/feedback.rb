ActiveAdmin.register Feedback do
  actions :index, :show, :destroy

  index do
    selectable_column
    id_column
    column :user
    column :feedback_type
    column :title
    column :application
    column :created_at
    column :updated_at
    actions
  end

  filter :user_phone, :as => :string
  filter :title
  filter :content
  filter :created_at
  filter :updated_at
end
