ActiveAdmin.register Evaluation do
  menu parent: '订单'

  actions :index, :show

  config.batch_actions = false

  index do
    id_column
    column :order
    column :user
    column :store
    column :score
    column :note
    column :created_at
    actions
  end

  filter :score
end
